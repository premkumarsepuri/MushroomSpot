//
//  ContentView.swift
//  MushroomSpot
//
//  Created by prem on 19/4/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionViewModel
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("MushroomSpot")
                .font(.largeTitle)
                .bold()
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Login") {
                        Task {
                            let success = await viewModel.login()
                            if success {
                                // Update the shared session instead of using the login view model's isLoggedIn property.
                                session.isLoggedIn = true
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
    }
}
