//
//  Constants.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 27/5/24.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let fmt = ISO8601DateFormatter()

func isValidEmail(_ email: String) -> Bool {
      let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
      return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
}

func isValidPassword(_ password: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$", options: [])
    return regex.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.utf16.count)) != nil
}
