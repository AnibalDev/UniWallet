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
    
    var buttonCallback: (String, String) -> Void
    
    var body: some View {
        VStack {
            Text("Crear cuenta")
                .font(.title)
            //                .padding([.top], 10)
                .padding(5)
            Text("Usuario")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
            CustomTextField(value: $email, text: "Email")
            Text("Contraseña")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
            CustomSecureField(value: $password, label: "Contraseña")
            CustomSecureField(value: $repeatPassword, label: "Repetir contraseña")
            
            CustomButtonFill(buttonCallback: { buttonCallback(email, password) }, text: "Registrarse ", width: screenWidth - 50)
            
                .padding(8)
            
            HStack {
                Text("Ya tienes una cuenta?")
                Button("Ingresar sesión") {
                }
                .foregroundStyle(.pink)
            }
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
