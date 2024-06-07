//
//  ResetPasswordForm.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 2/6/24.
//

import SwiftUI

struct ResetPasswordForm: View {
    
    @State var email = ""
    @EnvironmentObject var vm: LoginViewModel
    @State var errorMessage = ""
    
    var loginCallback: () -> Void
    
    func reset() {
        if email == vm.user?.email {
            Task {
                do {
                    try await vm.changePassword()
                }
                catch {
                    print("Error: \(error)")
                    errorMessage = error.localizedDescription
                }
            }
        }
        loginCallback()
    }
    
    var body: some View {
        VStack {
            Text("Resetear Contraseña")
                .font(.title)
                .padding(5)
            Text("Email")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
            EmailTextField(value: $email)
            
            CustomButtonFill(buttonCallback: reset, text: "Enviar Correo", width: screenWidth - 50)
                .padding(8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.regularMaterial)
            //                .ignoresSafeArea()
        )
    }
}

//#Preview {
//    ResetPasswordForm()
//}
