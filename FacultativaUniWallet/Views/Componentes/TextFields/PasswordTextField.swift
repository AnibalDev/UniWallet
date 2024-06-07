//
//  CustomSecureField.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var text: String
    @State private var isSecured: Bool = true
    let title: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.black)
                        .accessibilityIdentifier("password")
                } else {
                    TextField(title, text: $text)
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.black)
                }
            }.padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.pink)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
                .fill(.tertiary)
        }
    }
}

#Preview {
    PasswordTextField(text: .constant("Contraseña"),  title: "Titulo")
}
