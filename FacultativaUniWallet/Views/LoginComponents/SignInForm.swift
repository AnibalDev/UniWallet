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
    
    var buttonCallback: (String, String) -> Void
    
    var body: some View {
        VStack {
            Text("Ingresar sesión")
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
            
            CustomButtonFill(buttonCallback: { buttonCallback(email, password)}, text: "Ingresar sesión", width: screenWidth - 50)
            
                .padding(8)
            Button("Olvidaste tu contraseña?") {
                
            }
            .foregroundStyle(.pink)
            HStack {
                Text("No tienes una cuenta?")
                Button("Crea una") {
//                    buttonCallback()
                }
                .foregroundStyle(.pink)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.regularMaterial)
        )
        
    }
}

//#Preview {
//    ExistingAccountView(buttonCallback: {})
//}
