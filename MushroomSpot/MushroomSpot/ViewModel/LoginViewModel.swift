//
//  LoginViewModel.swift
//  MushroomSpot
//
//  Created by prem on 19/4/25.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let service:APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    // Update the login function to return a Bool.
    func login() async -> Bool {
        // Validate the inputs
        guard Validators.isValidEmail(email) else {
            errorMessage = "Invalid email format"
            return false
        }

        guard Validators.isValidPassword(password) else {
            errorMessage = "Password must contain 8+ characters, upper, lower, number, and special character"
            return false
        }

        isLoading = true
        defer { isLoading = false }

        do {
            // Attempt login via your API service
            _ = try await service.login(email: email, password: password)
            return true
        } catch {
            errorMessage = "Login failed: \(error.localizedDescription)"
            return false
        }
    }
}
