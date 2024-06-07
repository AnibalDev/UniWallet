//
//  NewAccountView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct CreateAccountForm: View {
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    @State private var showingAlert = false
    
    @State var errorMessage = ""
    
    var loginCallback: () -> Void
    
    @EnvironmentObject var vm: LoginViewModel
    
    func createAccount() {
        if(!isValidEmail(email)) {
            errorMessage = "Correo invalido"
            showingAlert.toggle()
        }
        else if(!isValidPassword(password)){
            errorMessage = "Contraseña no segura"
            showingAlert.toggle()
        }
        else if(password != repeatPassword) {
            errorMessage = "Las contraseñas no coinciden"
            showingAlert.toggle()
        }
        else {
            Task {
                do {
                    try await vm.createAccount(email: email, password: password)
                }
                catch {
                    print("Error: \(error)")
                }
            }
        }
        
        
    }
    
    
    var body: some View {
        VStack {
            Text("Crear cuenta")
                .font(.title)
            //                .padding([.top], 10)
                .padding(5)
            Text("Usuario")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
            EmailTextField(value: $email)
            Text("Contraseña")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
            PasswordTextField(text: $password, title: "Contraseña")
            PasswordTextField(text: $repeatPassword, title: "Repetir contraseña")
            
            CustomButtonFill(buttonCallback: createAccount, text: "Registrarse", width: screenWidth - 50)
                .padding(8)
            
            HStack {
                Text("Ya tienes una cuenta?")
                Button("Ingresar sesión") {
                    loginCallback()
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
            //                .ignoresSafeArea()
        )
        
    }
}

//#Preview {
//    NewAccountView( buttonCallback: {})
//}
