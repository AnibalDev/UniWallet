//
//  CuentaAgendadaModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 26/5/24.
//

import Foundation

struct CuentaAgendadaModel: Identifiable {
    let id = UUID()
    var cuenta: CuentaModel
    let intervalDays: Int
    let owner: String
    var uid: String
    var nextPay: String
    
    func toDictionary() -> [String: Any] {
        return [
            "cuenta":  cuenta.toDictionary(),
            "intervalDays": intervalDays,
            "nextPay": nextPay,
            "owner": owner,
            "uid": uid
        ]
    }
    init(uid: String, clone: CuentaAgendadaModel)
    {
        self.cuenta = clone.cuenta
        self.intervalDays = clone.intervalDays
        self.owner = clone.owner
        self.uid = uid
        self.nextPay = clone.nextPay
    }
    init(uid: String, cuenta: CuentaModel, intervalDays: Int, owner: String, nextPay: String) {
        self.cuenta = cuenta
        self.intervalDays = intervalDays
        self.owner = owner
        self.nextPay = nextPay
        self.uid = uid
    }
    init(uid: String, data: [String: Any]) {
        self.cuenta = CuentaModel(data: data["cuenta"] as! [String : Any])
        self.intervalDays = data["intervalDays"] as! Int
        self.owner = data["owner"] as! String
        self.uid = uid
        self.nextPay =  data["nextPay"] as! String
    }
    
    func newDate() -> Date {
        let calendar = Calendar.current
        let nuevaFechaDePago = calendar.date(byAdding: .day, value: intervalDays, to: fmt.date(from: nextPay) ?? Date() )!
        return nuevaFechaDePago
    }
    
    var diasRestantes: String{
        return String(
            Calendar.current.dateComponents([.day], from: Date(), to: fmt.date(from:  nextPay)!).day!)
    }
}

