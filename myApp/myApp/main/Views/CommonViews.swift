//
//  CommonViews.swift
//  myApp
//
//  Created by tkt on 2025/06/20.
//

import SwiftUI

// MARK: - Header
struct AppHeaderView: View {
    var body: some View {
        HStack{
            Image("PoliLink_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            
            Spacer()
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
