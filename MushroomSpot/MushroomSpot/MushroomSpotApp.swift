//
//  MushroomSpotApp.swift
//  MushroomSpot
//
//  Created by prem on 19/4/25.
//

import SwiftUI

@main
struct MushroomSpotApp: App {
    @StateObject private var session = SessionViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(session) 
        }
    }
}
