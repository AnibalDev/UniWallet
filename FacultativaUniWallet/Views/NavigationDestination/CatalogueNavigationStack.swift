//
//  IngresosYEgresos.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 28/5/24.
//

import SwiftUI

struct CatalogueNavigationStack: View {
    
    @State var selectedType: Int = 0
    @State var listaCatalogo: [CuentaAgendadaModel] = []
    
    var cuentasAgendadas = [
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
    
    var cuentasFiltradas: [CuentaAgendadaModel] {
        var type = selectedType == 0 ? CategoriaCuentaEnum.ingreso : CategoriaCuentaEnum.egreso
        return cuentasAgendadas.filter({$0.cuenta.tipo == type})
    }
    
    var body: some View {
        NavigationStack {
            Divider()
            Picker("Seleccione la naturaleza de la cuenta", selection: $selectedType) {
                Text("Activos").tag(0)
                Text("Pasivos").tag(2)
            }
            .padding()
            .pickerStyle(.segmented)
            List(cuentasFiltradas) { cuenta in
                HStack {
                    Text(cuenta.cuenta.name)
                        .bold()
//                    Text(String(cuenta.))
                }
                
            }
            .navigationTitle("Catalogo de cuentas")
        }
    }
}

#Preview {
    CatalogueNavigationStack()
}
