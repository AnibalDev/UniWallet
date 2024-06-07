//
//  CustomTextField.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct EmailTextField: View {
    
    @Binding var value: String
    
    var body: some View {
        TextField("Email",text: $value)
        .foregroundStyle(.black)
        .textInputAutocapitalization(.never)
        .padding()
        .keyboardType(.emailAddress)
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
    EmailTextField(value: .constant(""))
}
