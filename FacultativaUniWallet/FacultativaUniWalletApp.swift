//
//  FacultativaUniWalletApp.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct FacultativaUniWalletApp: App {
    
    @StateObject var authManager: LoginViewModel
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    init() {
        FirebaseApp.configure()
        let authManager = LoginViewModel()
        _authManager = StateObject(wrappedValue: authManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
