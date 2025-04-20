//
//  UserProfileViewModel.swift
//  MushroomSpot
//
//  Created by prem on 20/4/25.
//

import Foundation
@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var profile: UserResponseData?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service:APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func loadUserProfile() async {
        isLoading = true
        do {
            profile = try await service.fetchUserProfile()
        } catch {
            errorMessage = "Failed to load profile"
        }
        isLoading = false
    }
}
