//
//  CuentaModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 26/5/24.
//

import Foundation


struct CuentaModel: Identifiable, Codable {
    var id = UUID()
    let name: String
    let monto: Decimal
    let description: String
    let tipoCuenta: String
    let category: String
    let owner: String
    
    init(data: [String: Any]) {
        name = data["name"] as! String
        monto = Decimal(string: data["monto"] as! String)!
        tipoCuenta = data["tipoCuenta"] as! String
        category = data["category"] as! String
        description = data["description"] as! String
        owner = data["owner"] as! String
    }
    init(name: String, monto: Decimal, tipoCuenta: String, category: String, owner: String, description: String) {
        self.name = name
        self.monto = monto
        self.tipoCuenta = tipoCuenta
        self.description = description
        self.category = category
        self.owner = owner
    }
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "monto": String(describing: monto),
            "tipoCuenta": tipoCuenta,
            "category":  category,
            "description": description,
            "owner": owner,
        ]
    }
}
