//
//  FondosView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import SwiftUI



struct FoundNavigationStack: View {
    
    @ObservedObject var vm = FoundViewModel()
    @State var selectedRange: Int = 7
    @State var searchText = ""
    var listaFiltrada: [CuentaAgendadaModel] = []
    
    var body: some View {
        NavigationStack {
            Divider()
            HStack {
                Text("Disponible")
                    .font(.title2)
                    .bold()
                Spacer()
                Text(vm.db.disponible, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .font(.title)
                    .bold()
                    .foregroundStyle(.cyan)
            }
            .padding()
            FondosDateFilter(selectedRange: $selectedRange)
            List(
                searchText.isEmpty ?  vm.db.cuentasAgendadas.filter({Int($0.diasRestantes) ?? 30 <= selectedRange}) :
                     vm.db.cuentasAgendadas.filter({Int($0.diasRestantes) ?? 30 <= selectedRange}).filter({$0.cuenta.name.localizedStandardContains(searchText)})
            ) { cuenta in
                FondosListCell(model: cuenta, saltarCallback: {vm.saltarCuentaAgendada(cuenta: cuenta)}, pagarCallback: {vm.pagarCuentaAgendada(cuenta: cuenta)})
            }
            .alert(isPresented: $vm.showingSaltarAlert) {
                Alert(
                    title: Text("Confirmación"),
                    message: Text("Deséa posponer la cuenta hasta la proxima fecha?."),
                    primaryButton: .default(
                        Text("Confirmar"),
                        action:{vm.saltarAlert()}
                        //                        action:{vm.saltarActualId()}
                    ),
                    secondaryButton: .destructive(
                        Text("Cancelar"),
                        action:{}
                    )
                )
            }
            .sheet(isPresented: $vm.sheetPresented) {
                NewCountView(cuentaCallback: vm.agregarCuenta, cuentaAgendadaCallback: vm.agregarCuentaAgendada)
            }
            .listStyle(.plain)
            .navigationTitle("Fondos")
            
            Spacer()
                .toolbar {
                    ToolbarItem() {
                        Button {
                            vm.sheetPresented.toggle()
                        } label: {
                            Label("Añadir", systemImage: "plus")
                        }
                    }
                }
        }
        .onAppear() {
            Task {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                selectedRange = 7
            }
        }
        .padding([.leading,.trailing])
        .searchable(text: $searchText)
    }
}


#Preview {
    FoundNavigationStack()
}

