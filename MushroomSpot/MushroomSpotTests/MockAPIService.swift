//
//  MockAPIService.swift
//  MushroomSpotTests
//
//  Created by prem on 20/4/25.
//

import Foundation
@testable import MushroomSpot

class MockAPIService: APIServiceProtocol {
    var mockMushrooms: [Mushroom] = []
    var shouldReturnError = false
    var mockUser: User?
    var mockUserProfile: UserResponseData?

    func fetchMushrooms() async throws -> [Mushroom] {
        if shouldReturnError {
        throw NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Simulated network error"])

        }
        return mockMushrooms
    }
    
    func login(email: String, password: String) async throws -> User {
           if shouldReturnError {
               throw URLError(.badServerResponse)
           }
           return mockUser ?? User(auth_token: "XER4566743466TTETGRE")
       }

       func fetchUserProfile() async throws -> UserResponseData {
           if shouldReturnError {
               throw URLError(.badServerResponse)
           }
           return mockUserProfile ?? UserResponseData(user: UserData(
            id: "1",
            username: "test_user",
            firstName: "Test",
            lastName: "User"
        ))
       }
    
}

