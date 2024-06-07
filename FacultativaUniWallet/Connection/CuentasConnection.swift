//
//  CuentasConnection.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 2/6/24.
//

import Foundation
import FirebaseFirestore

final class CuentasConnection: ObservableObject {
    
    static var shared: CuentasConnection = {
        let instance = CuentasConnection()
        return instance
    }()
    
    init() {
        loadHistory()
        loadCuentas()
    }
    
    
    let db = Firestore.firestore()
    
    @Published var cuentasAgendadas: [CuentaAgendadaModel] = []
    
    @Published var historialCuentas: [CuentaModel] = []
    @Published var historialIngresos: [CuentaModel] = []
    @Published var historialEgresos: [CuentaModel] = []
    
    @Published var disponible: Decimal = 0.0
    
    var cuentasFiltradas: [CuentaAgendadaModel] = []
    
    func calcularDisponible() -> Decimal {
        let positive = historialIngresos.reduce(0, {$0 + $1.monto})
        let negative = historialEgresos.reduce(0, {$0 + $1.monto})
        
        return positive - negative
    }
    
    func refreshCuentas() {
        loadCuentas()
        loadHistory()
    }
    
    func loadCuentas() {
        Task {
            if let snapshot = try await readAll(collection: "cuentasAgendadas") {
                cuentasAgendadas = []
                for document in snapshot.documents {
                    print(document.documentID)
                    let cuenta = CuentaAgendadaModel(uid: document.documentID, data: document.data())
                    cuentasAgendadas.append(cuenta)
                }
            }
        }
    }
    
    func loadHistory() {
        Task {
            if let snapshot = try await readAll(collection: "history") {
                historialCuentas = []
                for document in snapshot.documents {
                    let cuenta = CuentaModel(data: document.data())
                    historialCuentas.append(cuenta)
                }
            }
            historialIngresos = historialCuentas.filter({ $0.tipoCuenta == "ingreso" })
            historialEgresos = historialCuentas.filter({ $0.tipoCuenta == "egreso" })
            disponible = calcularDisponible()
        }
    }
    
    
    
    
    
    
    func readAll(collection: String) async throws ->  QuerySnapshot? {
        do {
            let snapshot = try await db.collection(collection).getDocuments()
            return snapshot
            
        } catch {
            print("Error getting documents: \(error)")
            throw error
        }
    }
    
    
    
    private func insert(data: [String:Any], collection: String) async throws -> DocumentReference? {
        do {
            let ref = try await db.collection(collection).addDocument(data: data)
            print("Document added with ID: \(ref.documentID)")
            return ref
        } catch {
            print("Error adding document: \(error)")
            throw error
        }
    }
    
    
    
    
    
    func insertCuentaAgendada(data: CuentaAgendadaModel)   {
        Task {
            if let ref = try await insert(data: data.toDictionary(), collection: "cuentasAgendadas") {
                cuentasAgendadas.append(CuentaAgendadaModel(uid: ref.documentID, clone: data))
            }
        }
    }
    func insertarCuenta(data: CuentaModel) {
        Task {
            if (try await insert(data: data.toDictionary(), collection: "history")) != nil {
                historialCuentas.append(data)
            }
        }
    }
    func updateCuentaAgendada(collection:String, uid: String, modify: [String:Any])
    {
        Task {
            let docref = db.collection(collection).document(uid)
            do {
                try await docref.updateData(modify)
                print("Document successfully updated")
            } catch {
                print("Error updating document: \(error)")
            }
        }
    }
    
    
}
