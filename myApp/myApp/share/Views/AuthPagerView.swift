//
//  AuthPagerView.swift
//  myApp
//
//  Created by kmjak on 2025/06/18.
//

import SwiftUI

struct AuthPagerView: View {
    enum AuthPage: Int {
        case login = 0
        case register = 1
    }
    
    @State private var selection: AuthPage = .login
    
    var body: some View {
        TabView(selection: $selection) {
            LoginView(selection: $selection)
                .tag(AuthPage.login)
            RegisterView(selection: $selection)
                .tag(AuthPage.register)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
