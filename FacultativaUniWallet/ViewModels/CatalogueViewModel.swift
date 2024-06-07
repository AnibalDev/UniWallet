//
//  CatalogueViewModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 3/6/24.
//

import Foundation

class CatalogueViewModel: Identifiable, ObservableObject {
    
    let id = UUID()
    @Published var db: CuentasConnection = CuentasConnection.shared
    @Published var selectedType: Int = 0
    
    var cuentasFiltradas: [CuentaAgendadaModel] {
        var type = selectedType == 0 ? TipoCuentaEnum.ingreso : TipoCuentaEnum.egreso
        return db.cuentasAgendadas.filter({$0.cuenta.tipoCuenta == type.rawValue})
    }
    
}
