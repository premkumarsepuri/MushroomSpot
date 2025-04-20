//
//  service.swift
//  MushroomSpot
//
//  Created by prem on 19/4/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchMushrooms() async throws -> [Mushroom]
    func login(email: String, password: String) async throws -> User
    func fetchUserProfile() async throws -> UserResponseData
}

class APIService:APIServiceProtocol {
    
    func login(email: String, password: String) async throws -> User {
        guard let url = URL(string: "http://demo5845085.mockable.io/api/v1/users/login") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let user = try JSONDecoder().decode(User.self, from: data)
            
            if let tokenData = user.auth_token.data(using: .utf8) {
                KeychainHelper.shared.save(tokenData, service: "MushroomSpotService", account: "auth_token")
            }
            
            return user
        } catch {
            print("API call failed: \(error.localizedDescription)")
            throw error
        }
    }
    
        func fetchMushrooms() async throws -> [Mushroom] {
            guard let url = URL(string: "http://demo5845085.mockable.io/api/v1/mushrooms") else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedResponse = try JSONDecoder().decode(MushroomResponse.self, from: data)
            return decodedResponse.mushrooms
        }
    
    func fetchUserProfile() async throws -> UserResponseData {
           guard let url = URL(string: "http://demo5845085.mockable.io/users/me") else {
               throw URLError(.badURL)
           }
           let (data, _) = try await URLSession.shared.data(from: url)
           return try JSONDecoder().decode(UserResponseData.self, from: data)
       }
}
