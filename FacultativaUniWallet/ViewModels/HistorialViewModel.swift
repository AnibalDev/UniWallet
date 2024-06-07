//
//  HistorialViewModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 3/6/24.
//

import Foundation

class HistorialViewModel: Identifiable, ObservableObject {
    
    let id = UUID()
    @Published var db: CuentasConnection = CuentasConnection.shared
    @Published var selectedType: Int = 0
    
    func calcular(categoria: String) -> Decimal {
        return db.historialCuentas.filter({$0.category == categoria}).map({$0.monto}).reduce(0,+)
    }
    
    
    
    
}
