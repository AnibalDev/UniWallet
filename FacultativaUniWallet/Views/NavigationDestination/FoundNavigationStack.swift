//
//  FondosView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import SwiftUI



struct FoundNavigationStack: View {
    
    @ObservedObject var vm = FoundViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                HStack {
                    Text("Disponible")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(String(vm.disponible))
                        .font(.title)
                        .bold()
                        .foregroundStyle(.cyan)
                }
                .padding()
                FondosDateFilter(selectedRange: $vm.selectedFilder)
                List(vm.cuentas) { cuenta in
                    FondosListCell(model: cuenta, saltarCallback: {vm.saltarCuentaAgendada(idCuenta: cuenta.id)}, pagarCallback: {vm.pagarCuentaAgendada(idCuenta: cuenta.id)})
                        
                }
                .alert(isPresented: $vm.showingSaltarAlert) {
                    Alert(
                        title: Text("Confirmación"),
                        message: Text("Deséa posponer la cuenta hasta la proxima fecha?."),
                        primaryButton: .default(
                            Text("Confirmar"),
                            action:{vm.saltarActualId()}
                        ),
                        secondaryButton: .destructive(
                            Text("Cancelar"),
                            action:{}
                        )
                    )
                }
                .sheet(isPresented: $vm.sheetPresented) {
                    NewCountView(buttonCallback: vm.agregarCuentaAgendada)
                }
                .listStyle(.plain)
                .navigationTitle("Fondos")
                
                Spacer()
            }
            .toolbar {
                ToolbarItem() {
                    Button {
                        vm.sheetPresented.toggle()
                    } label: {
                        Label("Añadir", systemImage: "plus")
                    }
                }
            }
            .padding([.leading,.trailing])
        }
        .searchable(text: $vm.searchText)
        
        
    }
}

#Preview {
    FoundNavigationStack()
}

