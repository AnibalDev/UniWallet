//
//  ExistingAccountView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct SignInForm: View {
    @State var email = ""
    @State var password = ""
    
    @State private var showingAlert = false
    @EnvironmentObject var vm: LoginViewModel
    @State var errorMessage = ""
    
    var newAccountCallback: () -> Void
    var forgetCallback: () -> Void
    
    func signIn() {
        Task {
            do {
                try await vm.signIn(email: email, password: password)
            }
            catch {
                print("Error: \(error)")
                errorMessage = error.localizedDescription
                showingAlert.toggle()
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Ingresar sesión")
                .font(.title)
                .padding(5)
            Text("Usuario")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
            EmailTextField(value: $email)
                .accessibilityIdentifier("email")
            Text("Contraseña")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
            PasswordTextField(text: $password, title: "8 o mas caracteres")
            Text("Contraseña")
            CustomButtonFill(buttonCallback: signIn, text: "Ingresar sesión", width: screenWidth - 50)
                .accessibilityIdentifier("signIn")
                .padding(8)
            Button("Olvidaste tu contraseña?") {
                forgetCallback()
            }
            .foregroundStyle(.pink)
            HStack {
                Text("No tienes una cuenta?")
                Button("Crea una") {
                    newAccountCallback()
                }
                .foregroundStyle(.pink)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error de credenciales"), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.regularMaterial)
        )
        
    }
}

//#Preview {
//    SignInForm()
//}
