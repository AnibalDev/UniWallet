//
//  OptionsButtonsView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

struct OptionsButtonsView: View {
   
    @ObservedObject var vm: LoginViewModel = LoginViewModel()
    var loginCallback: () -> Void
    var newAccountCallback: () -> Void
    
    var body: some View {
        VStack {
            Button {
                loginCallback()
            } label: {
                Text("Ingresar")
                    .padding()
                    .bold()
                    .frame(maxWidth: 300)
                    .foregroundStyle(.pink)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.pink, lineWidth: 1)
                    )
            }
            .accessibilityIdentifier("loginButton")
            .padding([.bottom], 20)
            Button {
                newAccountCallback()
            } label: {
                Text("Crear Cuenta")
                    .padding()
                    .bold()
                    .frame(maxWidth: 300)
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
}
//
//#Preview {
//    OptionsButtonsView()
//}
