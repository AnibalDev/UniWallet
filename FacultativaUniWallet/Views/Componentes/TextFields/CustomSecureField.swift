//
//  CustomSecureField.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct CustomSecureField: View {
    
    @Binding var value: String
    let label: String
    
    var body: some View {
        SecureField(text: $value) {
            Label(label, systemImage: "")
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
