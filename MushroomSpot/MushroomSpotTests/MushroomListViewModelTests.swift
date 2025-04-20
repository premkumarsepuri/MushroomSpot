//
//  MushroomListViewModelTests.swift
//  MushroomSpotTests
//
//  Created by prem on 20/4/25.
//

import XCTest
@testable import MushroomSpot

final class MushroomListViewModelTests: XCTestCase {

    func testLoadMushroomsSuccess() async {
        let mockService = MockAPIService()
        mockService.mockMushrooms = [
            Mushroom(id: "1", name: "Shiitake", latinName: "Lentinula edodes", profilePicture: "image/jpeg;base64,/9j/4AAQSkZJRgABAQAAS7aNlw9I27W2wAEsNtCnTLEIABBZpxJ4IAIRPEkQAZahyHIAAchQABUKAAAAAAAAB/9k=")
        ]
        let viewModel = MushroomListViewModel(service: mockService)

        await viewModel.loadMushrooms()

        XCTAssertEqual(viewModel.mushrooms.count, 1)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadMushroomsWithEmptyResponse() async {
        let mockService = MockAPIService()
        mockService.mockMushrooms = []  // Simulate empty array
        let viewModel = MushroomListViewModel(service: mockService)

        await viewModel.loadMushrooms()

        XCTAssertTrue(viewModel.mushrooms.isEmpty, "Expected empty mushrooms list")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadMushroomsWithDuplicates() async {
        let mockService = MockAPIService()
        let mushroom = Mushroom(id: "1", name: "Morel", latinName: "Morchella", profilePicture: "url")
        mockService.mockMushrooms = [mushroom, mushroom]  // Duplicate ID
        let viewModel = MushroomListViewModel(service: mockService)

        await viewModel.loadMushrooms()

        XCTAssertEqual(viewModel.mushrooms.count, 2, "Should load duplicates if backend returns them")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testMultipleLoadMushroomsCalls() async {
        let mockService = MockAPIService()
        mockService.mockMushrooms = [
            Mushroom(id: "1", name: "Chanterelle", latinName: "Cantharellus cibarius", profilePicture: "url")
        ]
        let viewModel = MushroomListViewModel(service: mockService)

        await viewModel.loadMushrooms()
        await viewModel.loadMushrooms()  // Call again

        XCTAssertEqual(viewModel.mushrooms.count, 1)
        XCTAssertNil(viewModel.errorMessage)
    }


}
