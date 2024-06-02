//
//  File.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 26/5/24.
//

import Foundation

class FoundViewModel: Identifiable, ObservableObject {
    
    let id = UUID()
    
    @Published var searchText = ""
    @Published var selectedFilder = 0
    @Published var showingSaltarAlert = false
    @Published var disponible: Int = 0
    @Published var sheetPresented = false
    
    var cuentas: [CuentaAgendadaModel] {
        return searchText.isEmpty ? cuentasAgendadas : cuentasAgendadas.filter({$0.cuenta.name.localizedStandardContains(searchText)})
    }
    init() {
       disponible = calcularDisponible()
    }
    
    func calcularDisponible() -> Int {
        let positive = historialIngresos.reduce(0, {$0 + $1.monto})
        let negative = historialEgresos.reduce(0, {$0 + $1.monto})
        
        return positive - negative
    }
    
    
    @Published var historialCuentas: [CuentaModel] = [
        CuentaModel(name: "Test", monto: 1000, nextPay: Date(), tipo: .ingreso),
        CuentaModel(name: "Test", monto: 1000, nextPay: Date(), tipo: .ingreso),
        CuentaModel(name: "Test", monto: 1000, nextPay: Date(), tipo: .ingreso),
    ]
    func agregarCuentaAgendada(cuentaAgendada: CuentaAgendadaModel) {
        cuentasAgendadas.append(cuentaAgendada)
        sheetPresented.toggle()
    }
    
    @Published var cuentasAgendadas = [
        CuentaAgendadaModel(
            cuenta: CuentaModel(name: "test1", monto: 1500, nextPay: fmt.date(from: "2024-06-01T00:00:00+0000")!, tipo: .ingreso),
            intervalDays: 30),
        CuentaAgendadaModel(
            cuenta: CuentaModel(name: "test2", monto: 1500, nextPay: fmt.date(from: "2024-06-05T00:00:00+0000")!, tipo: .egreso),
            intervalDays: 30),
        CuentaAgendadaModel(
            cuenta: CuentaModel(name: "test3", monto: 1500, nextPay: fmt.date(from: "2024-06-09T00:00:00+0000")!, tipo: .ingreso),
            intervalDays: 30),
    ]
    var actualID: UUID? = nil
    
    func saltarCuentaAgendada(idCuenta: UUID) {
        showingSaltarAlert.toggle()
        actualID = idCuenta
    }
    
    func saltarActualId() {
        if let row = self.cuentasAgendadas.firstIndex(where: {$0.id == actualID!}) {
            cuentasAgendadas[row].pagar()
        }
    }
    
    
    func pagarCuentaAgendada(idCuenta: UUID) {
        if let row = self.cuentasAgendadas.firstIndex(where: {$0.id == idCuenta}) {
            
            historialCuentas.append(cuentasAgendadas[row].cuenta)
            cuentasAgendadas[row].pagar()
        }
        disponible = calcularDisponible()
        print(disponible)
    }
    
    
    var historialIngresos: [CuentaModel] {
        return historialCuentas.filter({ $0.tipo == .ingreso })
    }
    
    var historialEgresos: [CuentaModel] {
        return historialCuentas.filter({ $0.tipo == .egreso })
    }
    
}
