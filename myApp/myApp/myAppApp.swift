//
//  myAppApp.swift
//  myApp
//
//  Created by kmjak on 2025/06/15.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct myAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delzegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
