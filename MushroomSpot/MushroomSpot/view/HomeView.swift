//
//  HomeView.swift
//  MushroomSpot
//
//  Created by prem on 19/4/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = MushroomListViewModel()
    @StateObject var profileVM = UserProfileViewModel()
    @EnvironmentObject var session: SessionViewModel

    @State private var showProfileSheet = false

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Mushrooms")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task {
                                await profileVM.loadUserProfile()
                                showProfileSheet = true
                            }
                        }) {
                            Image(systemName: "person.circle")
                        }
                    }
                }
                .sheet(isPresented: $showProfileSheet) {
                    if let profile = profileVM.profile {
                        Text("Profile Details")
                        .font(.largeTitle)
                        .bold()
                        VStack(spacing: 16) {
                            Text("first name: \(profile.user.firstName)")
                            Text("last name: \(profile.user.firstName)")
                            Text("Email: \(profile.user.username)")
                            Button("Logout") {
                                session.logout()
                            }
                        }
                        .padding()
                    } else if profileVM.isLoading {
                        ProgressView("Loading...")
                    } else {
                        Text(profileVM.errorMessage ?? "No Profile Data")
                    }
                }
        }
        .onAppear {
           // viewModel.loadMushrooms()
            Task {
                await viewModel.loadMushrooms()
            }
        }
    }

    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let errorMessage = viewModel.errorMessage {
            Text("Error: \(errorMessage)")
        } else {
            List(viewModel.mushrooms) { mushroom in
                NavigationLink(value: mushroom) {
                    HStack {
                        Text(mushroom.name)
                        Spacer()
                        if let base64 = mushroom.profilePicture.components(separatedBy: ",").last,
                           let imageData = Data(base64Encoded: base64),
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
            .navigationDestination(for: Mushroom.self) { mushroom in
                MushroomDetailView(mushroom: mushroom)
            }
        }
    }
}
