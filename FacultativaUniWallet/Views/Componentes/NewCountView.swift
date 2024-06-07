//
//  NewCountView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 28/5/24.
//

import SwiftUI

struct NewCountView: View {
    @State var titulo = ""
    @State var description = ""
    @State private var selectedRepetition: Repetisiones = .semanal
    @State private var selectedDate: Date = Date()
    @State private var selectedTipo: TipoCuentaEnum = .egreso
    @State private var selectedCategoriaIngreso: CategoriaIngresos = .beca
    @State private var selectedCategoriaEgreso: CategoriaEgresos = .comida
    
    
    @State var monto: Decimal = 100.0
    @State var agendada: Bool = false
    
    @ObservedObject var vm: LoginViewModel = LoginViewModel()
    
    var cuentaCallback: (CuentaModel) -> Void
    var cuentaAgendadaCallback: (CuentaAgendadaModel) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Titulo", text: $titulo)
                    TextField("Descripción", text: $description)
                }
                Section {
                    LabeledContent("Monto") {
                        TextField("Amount", value: $monto, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundStyle(.secondary)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    if(agendada) {
                        Picker("Repetición", selection: $selectedRepetition) {
                            Text("Semanal").tag(Repetisiones.semanal)
                            Text("Quincenal").tag(Repetisiones.quincenal)
                            Text("Mensual").tag(Repetisiones.mensual)
                        }
                    }
                    Picker("Tipo", selection: $selectedTipo) {
                        Text("Egreso").tag(TipoCuentaEnum.egreso)
                        Text("Ingreso").tag(TipoCuentaEnum.ingreso)
                    }
                    if(selectedTipo == .ingreso) {
                        Picker("Categoria", selection: $selectedCategoriaIngreso) {
                            Text("Beca").tag(CategoriaIngresos.beca)
                            Text("Mesada").tag(CategoriaIngresos.mesada)
                            Text("Sueldo").tag(CategoriaIngresos.sueldo)
                            Text("Otro").tag(CategoriaIngresos.otro)
                        }
                    }
                    else {
                        Picker("Categoria", selection: $selectedCategoriaEgreso) {
                            Text("Vestuario 🥼").tag(CategoriaEgresos.vestuario)
                            Text("Comida 🌽").tag(CategoriaEgresos.comida)
                            Text("Electricidad ⚡️").tag(CategoriaEgresos.electricidad)
                            Text("Hogar 🏠").tag(CategoriaEgresos.hogar)
                            Text("Transporte 🚕").tag(CategoriaEgresos.transporte)
                            Text("Papeleria 🖇️").tag(CategoriaEgresos.papeleria)
                            Text("Ocio 🎪").tag(CategoriaEgresos.ocio)
                            Text("Agua 💧").tag(CategoriaEgresos.agua)
                            Text("Otro 🦑").tag(CategoriaEgresos.otro)
                        }
                    }
                    Toggle("Agendada", isOn: $agendada)
                    
                } header: {
                    Text("Datos")
                }
                if (agendada) {
                    Section {
                        
                        DatePicker("Fecha Inicio", selection: $selectedDate, displayedComponents: [.date])
                    } header: {
                        Text("Agendación")
                    }
                }
                
                HStack {
                    Spacer()
                    LabeledContent("Guardar cuenta") {
                        Button("Confirmar") {
                            let selectedCategoria = selectedTipo == .ingreso ? selectedCategoriaIngreso.rawValue : selectedCategoriaEgreso.rawValue
                            let cuenta = CuentaModel(name: titulo, monto: monto, tipoCuenta: selectedTipo.rawValue, category: selectedCategoria, owner: vm.user?.email ?? "", description: description)
                            
                            if agendada {
                                let cuentaAgendada = CuentaAgendadaModel(uid: "", cuenta: cuenta, intervalDays: selectedRepetition.rawValue, owner: vm.user?.email ?? "", nextPay: fmt.string(from: selectedDate))
                                cuentaAgendadaCallback(cuentaAgendada)
                            }
                            else {
                                cuentaCallback(cuenta)
                            }
                            
                        }
                        .tint(.cyan)
                    }
                }
            }
            .navigationTitle("Nueva Cuenta")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

//#Preview {
//    NewCountView( )
//}
