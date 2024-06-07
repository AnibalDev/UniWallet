//
//  File.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 26/5/24.
//

import Foundation

class FoundViewModel: Identifiable, ObservableObject {
    
    let id = UUID()
    @Published var db: CuentasConnection = CuentasConnection.shared
   
    @Published var showingSaltarAlert = false
    @Published var fondosInsuficientesAlert = false
    @Published var sheetPresented = false
    
//    var cuentas: [CuentaAgendadaModel] {
//        return searchText.isEmpty ? db.cuentasAgendadas : db.cuentasAgendadas.filter({$0.cuenta.name.localizedStandardContains(searchText)})
//    }
    init() {
        //            disponible = calcularDisponible()
    }
    
    func agregarCuentaAgendada(cuentaAgendada: CuentaAgendadaModel) {
        db.insertCuentaAgendada(data: cuentaAgendada)
        sheetPresented.toggle()
        
    }
    func agregarCuenta(cuenta: CuentaModel) {
        if(cuenta.tipoCuenta == "egreso" && db.disponible - cuenta.monto < 0) {
            sheetPresented.toggle()
            
            Task {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                fondosInsuficientesAlert = true
            }
        }
        else
        {
            db.insertarCuenta(data: cuenta)
            sheetPresented.toggle()
        }
        
        db.refreshCuentas()
    }
    
    
    var cuentaTemporal: CuentaAgendadaModel?
    func saltarCuentaAgendada(cuenta: CuentaAgendadaModel) {
        showingSaltarAlert = true
        cuentaTemporal = cuenta
    }
    func saltarAlert()
    {
        if let cuenta = cuentaTemporal {
            db.updateCuentaAgendada(collection: "cuentasAgendadas", uid: cuenta.uid, modify: ["nextPay": fmt.string(from: cuenta.newDate())])
        }
        db.refreshCuentas()
        print()
    }
    
    func pagarCuentaAgendada(cuenta: CuentaAgendadaModel) {
        if(cuenta.cuenta.tipoCuenta == "egreso" && db.disponible - cuenta.cuenta.monto < 0) {
            sheetPresented.toggle()
            
            Task {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                fondosInsuficientesAlert = true
            }
        }
        else
        {
            db.insertarCuenta(data: cuenta.cuenta)
            db.updateCuentaAgendada(collection: "cuentasAgendadas", uid: cuenta.uid, modify: ["nextPay":  fmt.string(from: cuenta.newDate())])
        }
        db.refreshCuentas()
    }
    
    
    
    
    
}
