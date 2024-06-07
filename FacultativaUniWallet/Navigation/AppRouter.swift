//
//  AppRouter.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 31/5/24.
//

import Foundation
import SwiftUI

enum AppScreen: Hashable ,CaseIterable, Identifiable {
    case found
    case catalogue
    case history
    case settings
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .found:
            Label("Fondos",systemImage: "dollarsign.circle")
        case .catalogue:
            Label("Catalogo",systemImage: "bookmark.fill")
        case .history:
            Label("Historial",systemImage: "list.bullet.clipboard.fill")
        case .settings:
            Label("Configuración",systemImage: "gear")
        }
    }
    
    var title: String {
        switch self {
        case .found:
            return "Fondos"
        case .catalogue:
            return "Catalogo"
        case .history:
            return "Historial"
        case .settings:
            return "Ajustes"
        }
    }
    
    var iconName: String {
        switch self {
        case .found:
            return "house"
        case .catalogue:
            return "star"
        case .history:
            return "message.fill"
        case .settings:
            return "person"
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .found:
            FoundNavigationStack()
        case .catalogue:
            CatalogueNavigationStack()
        case .history:
            HistoryNavigationStack()
        case .settings:
            SettingsNavigationStack()
        }
    }
}
