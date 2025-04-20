//
//  KeychainHelper.swift
//  MushroomSpot
//
//  Created by prem on 19/4/25.
//

import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
   
    func save(_ data: Data, service: String, account: String) {
        // Delete old item first (if it exists)
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        SecItemDelete(query)

        // Add new item
        let attributes = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: data
        ] as CFDictionary

        let status = SecItemAdd(attributes, nil)
        if status != errSecSuccess {
            print("🔒 Failed to save in Keychain with status: \(status)")
        }
    }

    func read(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        if status == errSecSuccess {
            return result as? Data
        }
        return nil
    }

    func deleteAuthToken() {
           let query = [
               kSecClass: kSecClassGenericPassword,
               kSecAttrService: "MushroomSpotService",
               kSecAttrAccount: "auth_token"
           ] as CFDictionary

           let status = SecItemDelete(query)
           if status != errSecSuccess {
               print("🔒 Failed to delete from Keychain with status: \(status)")
           }
       }
}

