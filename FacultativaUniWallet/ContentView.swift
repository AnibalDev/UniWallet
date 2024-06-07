//
//  ContentView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: AppScreen? = .found
    @EnvironmentObject var authManager: LoginViewModel
    init() {
        var db: CuentasConnection = CuentasConnection.shared
    }
    
    var body: some View {
        
        if authManager.authState == .signedOut {
           LoginView()
        }
        else {
            TabNavigatorView(selection: $selectedTab)
        }
        
    }
}
//
//#Preview {
//    ContentView()
//}
