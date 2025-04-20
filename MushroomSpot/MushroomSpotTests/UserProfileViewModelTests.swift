//
//  UserProfileViewModelTests.swift
//  MushroomSpotTests
//
//  Created by prem on 20/4/25.
//
import XCTest

@testable import MushroomSpot

final class UserProfileViewModelTests: XCTestCase {

    func testFetchUserProfileSuccess() async {
        // Arrange
        let mockService = MockAPIService()
        mockService.mockUserProfile = UserResponseData(user: UserData(
            id: "1",
            username: "test_user",
            firstName: "Test",
            lastName: "User"
        ))
        let viewModel = await UserProfileViewModel(service: mockService)

        // Act
        await viewModel.loadUserProfile()

        // Assert (Accessing actor-isolated properties safely)
        await MainActor.run {
            XCTAssertNotNil(viewModel.profile?.user.username)
            XCTAssertEqual(viewModel.profile?.user.username, "test_user")
            XCTAssertNil(viewModel.errorMessage)
        }
    }

    func testFetchUserProfileFailure() async {
            // Arrange
            let mockService = MockAPIService()
            mockService.shouldReturnError = true
        let viewModel = await UserProfileViewModel(service: mockService)

            // Act
            await viewModel.loadUserProfile()

            // Assert
            await MainActor.run {
                XCTAssertNil(viewModel.profile?.user)
                XCTAssertNotNil(viewModel.errorMessage)
                XCTAssertTrue(viewModel.errorMessage?.contains("Failed to load profile") ?? false)
            }
        }
}
