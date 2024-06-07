//
//  FondosListCellModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import Foundation


enum TipoCuentaEnum: String, Codable, CaseIterable {
    case ingreso, egreso
    var id: Self {self}
}

enum CategoriaIngresos: String, Codable,CaseIterable {
    case beca, sueldo, mesada, otro
    var id: Self {self}
}

enum CategoriaEgresos: String, Codable, CaseIterable {
    case electricidad, comida, transporte, papeleria, agua, vestuario, ocio, hogar, otro
    var id: Self {self}
}
