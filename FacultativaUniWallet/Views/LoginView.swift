//
//  LoginView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import SwiftUI
import FirebaseAuth

enum LoginStates {
    case notSelected
    case newAccount
    case login
    case resetPassword
}

struct LoginView: View {
    
    @State var estado: LoginStates = .notSelected
    @ObservedObject var vm: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Image("BackgroundLogin")
                .resizable()
                .scaledToFit()
                .offset(x:0 , y: -50)
            VStack {
                Text("UniWallet")
                    .font(.largeTitle)
                    .bold()
                    .padding([.top], 50)
                Spacer()
                switch estado {
                case .login:
                    SignInForm(newAccountCallback: {
                        estado = .newAccount
                    }, forgetCallback: { estado = .resetPassword})
                case .newAccount:
                    CreateAccountForm(loginCallback: { estado = .login })
                case .notSelected:
                    OptionsButtonsView(loginCallback: {estado = .login}, newAccountCallback: {estado = .newAccount})
                case .resetPassword:
                    ResetPasswordForm( loginCallback: {estado = .login})
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
