//
//  MushroomModel.swift
//  MushroomSpot
//
//  Created by prem on 20/4/25.
//

import Foundation

// MARK: - Mushroom Model
struct Mushroom: Codable, Identifiable,Hashable {
    let id: String  // The id is a string based on your API response
    let name: String
    let latinName: String
    let profilePicture: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case latinName = "latin_name"
        case profilePicture = "profile_picture"
    }
}

// MARK: - MushroomResponse (Wrapper for the Array of Mushrooms)
struct MushroomResponse: Codable {
    let mushrooms: [Mushroom]
}
