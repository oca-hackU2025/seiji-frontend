//
//  MainView.swift
//  myApp
//
//  Created by tkt on 2025/06/20.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            AppHeaderView()
            
            // 境界線
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.vertical, 12)
            
            // Content
            Group {
                if selectedTab == 0 {
                    ListView()
                } else {
                    LikesView()
                }
            }
            
            // 境界線
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.vertical, 12)
            
            
            // Footer
            AppFooterView(selectedTab: $selectedTab)
        }
        .background(.white)
    }
}

#Preview {
    MainView()
}
