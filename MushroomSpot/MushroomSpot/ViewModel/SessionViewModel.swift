//
//  SessionViewModel.swift
//  MushroomSpot
//
//  Created by prem on 20/4/25.
//

import Foundation
class SessionViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    private let keychainHelper = KeychainHelper()

    func logout() {
        // Step 1: Remove token from Keychain
        keychainHelper.deleteAuthToken()

        // Step 2: Update login status
        DispatchQueue.main.async {
            self.isLoggedIn = false
        }
    }
}
