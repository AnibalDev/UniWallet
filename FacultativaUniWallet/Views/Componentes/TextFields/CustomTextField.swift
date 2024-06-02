//
//  CustomTextField.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var value: String
    let text: String
    
    var body: some View {
        TextField(text: $value) {
            Label(text, systemImage: "")
        }
        .textInputAutocapitalization(.never)
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

