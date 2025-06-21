//
//  AuthPagerView.swift
//  myApp
//
//  Created by kmjak on 2025/06/18.
//

import SwiftUI

struct AuthPagerView: View {
    
    @State private var selection: Int = 0
    
    var body: some View {
        NonSwipeableTabView(selection: $selection) {
            LoginView(selection: $selection)
                .tag(0)
            RegisterView(selection: $selection)
                .tag(1)
        }
    }
}

struct NonSwipeableTabView<Content: View>: View {
    @Binding var selection: Int
    let content: () -> Content
    
    init(selection: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.content = content
    }
    
    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .gesture(DragGesture()) // スワイプをキャッチして無効化
        .highPriorityGesture(DragGesture()) // 優先度高でスワイプ無視
    }
}
