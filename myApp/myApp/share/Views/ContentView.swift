//
//  ContentView.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authManager = AuthManager()
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainView()
            } else {
                AuthPagerView()
            }
        }
        .environmentObject(authManager)
    }
}
