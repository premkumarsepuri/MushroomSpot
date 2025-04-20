//
//  MushroomListViewModel.swift
//  MushroomSpot
//
//  Created by prem on 20/4/25.
//
import Foundation
import SwiftUI

class MushroomListViewModel: ObservableObject {
    @Published var mushrooms: [Mushroom] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service:APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    @MainActor
        func loadMushrooms() async {
            isLoading = true
            do {
                let result = try await service.fetchMushrooms()
                mushrooms = result
                isLoading = false
            } catch {
                errorMessage = "Failed to load mushrooms: \(error.localizedDescription)"
                isLoading = false
            }
        }
}
