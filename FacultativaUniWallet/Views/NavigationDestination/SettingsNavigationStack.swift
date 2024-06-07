//
//  SettingsNavigationStack.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 2/6/24.
//

import SwiftUI

struct SettingsNavigationStack: View {
    @EnvironmentObject var authManager: LoginViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        NavigationStack {
            Divider()
            Form {
                Section {
                    LabeledContent("Email") {
                        Text(authManager.user?.email ?? "")
                            .font(.system(size: 12))
                    }
                } header: {
                    Text("Datos")
                }
                Section {
                    LabeledContent("Cambiar Contraseña") {
                        Button {
                            Task {
                                do {
                                    try await authManager.changePassword()
                                }
                                catch {
                                    print("Error: \(error)")
                                }
                            }
                        } label: {
                            Image(systemName: "gear")
                        }
                        .buttonStyle(.borderless)
                    }
                    Toggle("Modo oscuro", isOn: $isDarkMode)
                    
                } header: {
                    Text("Opciones")
                }
                
                
                HStack {
                    Spacer()
                    Button("Cerrar seseión") {
                        Task {
                            do {
                                try await authManager.signOut()
                            }
                            catch {
                                print("Error: \(error)")
                            }
                        }
                    }
                }
            }
                .navigationTitle("Configuración")
        }
    }
}

#Preview {
    SettingsNavigationStack()
}
