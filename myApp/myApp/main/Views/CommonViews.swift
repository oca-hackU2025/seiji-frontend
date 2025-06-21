//
//  CommonViews.swift
//  myApp
//
//  Created by tkt on 2025/06/20.
//

import SwiftUI

// MARK: - Header
struct AppHeaderView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var isLoggingOut = false
    
    var body: some View {
        HStack {
            Image("PoliLink_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            
            Spacer()
            
            Button(action: {
                isLoggingOut = true
                authManager.logout()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isLoggingOut = false
                }
            }) {
                Text("ログアウト")
                    .opacity(isLoggingOut ? 0.5 : 1.0)
            }
        }
        .padding(.horizontal, 16)
        .background(.white)
    }
}

// MARK: - Footer
struct AppFooterView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            // Home
            Button(action: {
                selectedTab = 0
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "house.fill")
                        .font(.title2)
                    Text("Home")
                        .font(.caption)
                }
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = 1
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                    Text("Likes")
                        .font(.caption)
                }
            }
        }
        .foregroundStyle(.black)
        .padding(.horizontal, 100)
        .background(.white)
    }
}
