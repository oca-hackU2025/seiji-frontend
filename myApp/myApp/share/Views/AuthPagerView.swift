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
        TabView(selection: $selection) {
            LoginView(selection: $selection)
                .tag(0)
            RegisterView(selection: $selection)
                .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
