//
//  IngresosYEgresos.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 28/5/24.
//

import SwiftUI

struct CatalogueNavigationStack: View {
    
    @ObservedObject var vm = CatalogueViewModel()
    
    var body: some View {
        NavigationStack {
            Divider()
            Picker("Seleccione la naturaleza de la cuenta", selection: $vm.selectedType) {
                Text("Activos").tag(0)
                Text("Pasivos").tag(1)
            }
            .padding()
            .pickerStyle(.segmented)
            List(vm.cuentasFiltradas) { cuenta in
                HStack {
                    VStack {
                        LabeledContent {
                            Text(cuenta.cuenta.name.uppercased())
                        } label: {
                            Text("Titulo")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(cuenta.intervalDays))
                        } label: {
                            Text("Intervalo")
                                .bold()
                        }
                        LabeledContent {
                            Text(cuenta.cuenta.category.uppercased())
                        } label: {
                            Text("Categoría")
                                .bold()
                        }
                        LabeledContent {
                            Text(cuenta.cuenta.monto, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(cuenta.cuenta.tipoCuenta == "ingreso" ? .green : .red)
                        } label: {
                            Text("Monto")
                                .bold()
                        }
                    }
                    .padding([.trailing], 20)
                    VStack{
                        Button {
                        } label: {
                            Image(systemName: "gear")
                        }
                        .buttonStyle(.bordered)
                        Button {
                        } label: {
                            Image(systemName: "trash.fill")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(4)
                
            }
                .navigationTitle("Catalogo de cuentas")
        }
    }
}

#Preview {
    CatalogueNavigationStack()
}
