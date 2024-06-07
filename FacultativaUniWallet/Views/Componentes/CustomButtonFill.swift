//
//  CustomButtonFill.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct CustomButtonFill: View {
    var buttonCallback: () -> Void
    let text: String
    let width: CGFloat
    
    var body: some View {
        Button {
            buttonCallback()
        } label: {
            Text(text)
                .padding()
                .bold()
//                .frame(maxWidth: width)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(
                        cornerRadius: 12
                    )
                    .fill(.pink)
                )
        }
    }
}

#Preview {
    CustomButtonFill(buttonCallback: {}, text: "Test", width: 400)
}
