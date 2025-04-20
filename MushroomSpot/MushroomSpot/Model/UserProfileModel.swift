//
//  UserProfileModel.swift
//  MushroomSpot
//
//  Created by prem on 20/4/25.
//

// User.swift
struct UserResponseData: Codable {
    let user: UserData
}

struct UserData: Codable, Identifiable {
    let id: String
    let username: String
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

