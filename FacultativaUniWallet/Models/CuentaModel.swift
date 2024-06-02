//
//  CuentaModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 26/5/24.
//

import Foundation




struct CuentaModel: Identifiable {
    let id = UUID()
    let name: String
    let monto: Int
    let fechaPago: Date
    let tipo: CategoriaCuenta
}

struct CuentaAgendadaModel: Identifiable {
    let id = UUID()
    let cuenta: CuentaModel
    let intervalDays: Int
    var lastPay: Date
    
    private func formatNumberToThousand() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        let formattedNumber = numberFormatter.string(from: NSNumber(value: cuenta.monto))
        return formattedNumber ?? ""
    }
}


