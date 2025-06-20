//
//  AuthManager.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/20.
//

import Foundation
import Combine

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    init() {
        checkAuthenticationStatus()
    }
    
    func checkAuthenticationStatus() {
        if let _ = KeychainHelper.load() {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
    
    func login() {
        isAuthenticated = true
    }
    
    func logout() {
        KeychainHelper.delete()
        isAuthenticated = false
    }
}
