//
//  FondosListCellModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import Foundation


enum TipoCuentaEnum: String, Codable {
    case ingreso, egreso
    var id: Self {self}
}

