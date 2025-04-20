//
//  RootView.swift
//  MushroomSpot
//
//  Created by prem on 20/4/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionViewModel

    var body: some View {
        Group {
            if session.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

