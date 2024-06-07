//
//  HistoryView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 1/6/24.
//

import SwiftUI

struct HistoryNavigationStack: View {
    @ObservedObject var vm = HistorialViewModel()
    
    var body: some View {
        NavigationStack {
            Divider()
            Picker("Seleccione la naturaleza de la cuenta", selection: $vm.selectedType) {
                Text("General").tag(0)
                Text("Categorías").tag(1)
            }
            .padding()
            .pickerStyle(.segmented)
            .navigationTitle("Historial de cuentas")
            if( vm.selectedType == 0) {
                List(vm.db.historialCuentas) { cuenta in
                    VStack {
                        LabeledContent {
                            Text(cuenta.monto, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(cuenta.tipoCuenta == "ingreso" ? .green : .red)
                        } label: {
                            Text(cuenta.name)
                            //                            .bold()
                        }
                    }
                }
            } else {
                List {
                    Section {
                        
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "beca")))
                        } label: {
                            Text("Beca 📚")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "sueldo")))
                        } label: {
                            Text("Sueldo 💻")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "mesada")))
                        } label: {
                            Text("Mesada ⚖️")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "otro")))
                        } label: {
                            Text("Otro 👤")
                                .bold()
                        }
                        
                    } header: {
                        Text("Activos")
                    }
                    
                    Section {
                        
                        
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "electricidad")))
                        } label: {
                            Text("Electricidad 💡")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "comida")))
                        } label: {
                            Text("Comida 🌽")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "transporte")))
                        } label: {
                            Text("Transporte 🚕")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "papeleria")))
                        } label: {
                            Text("Papeleria 🖇️")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "agua")))
                        } label: {
                            Text("Agua 💧")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "vestuario")))
                        } label: {
                            Text("Vestuario 👚")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "ocio")))
                        } label: {
                            Text("Ocio 📱")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "hogar")))
                        } label: {
                            Text("Hogar 🏡")
                                .bold()
                        }
                        LabeledContent {
                            Text(String(describing: vm.calcular(categoria: "otro")))
                        } label: {
                            Text("Otro 👤")
                                .bold()
                        }
                        
                    } header: {
                        Text("Pasivos")
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryNavigationStack()
}
