//
//  FondosListCell.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import SwiftUI


extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

struct FondosListCell: View {
    
    let model: CuentaAgendadaModel
    var saltarCallback: () -> Void
    var pagarCallback: () -> Void
    
    @State private var showingAlert = false
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, content: {
                Text(model.cuenta.name)
                    .foregroundStyle(.secondary)
                Text(model.cuenta.monto.formatted())
                    .bold()
                    .font(.system(size: 30))
                    .foregroundStyle(model.cuenta.tipoCuenta == TipoCuentaEnum.ingreso.rawValue ? .green : .pink)
            })
            Spacer()
            Text(model.diasRestantes + " días restantes")
                .foregroundStyle(Int(model.diasRestantes)! > 3 ? .cyan : .orange)
                .font(.system(size: 20))
          
        }
        .listRowInsets(.init(top: 8,
                             leading: 0,
                             bottom: 8,
                             trailing: 8))
        .swipeActions() {
            Button("Saltar") {
                saltarCallback()
            }
            .tint(.gray)
            
            Button(model.cuenta.tipoCuenta == TipoCuentaEnum.ingreso.rawValue ? "Recibir" : "Pagar") {
                pagarCallback()
            }
            .tint(model.cuenta.tipoCuenta == TipoCuentaEnum.ingreso.rawValue ? .green : .pink)
        }
        
    }
}

//#Preview {
//    FondosListCell(model: CuentaAgendadaModel(cuenta: CuentaModel(name: "Test", monto: 1000, nextPay: fmt.date(from: "2025-08-06T19:20:42+0000")!, tipoCuenta: "Ingreso", category: ""), intervalDays: 7), saltarCallback: {}, pagarCallback: {})
//}
