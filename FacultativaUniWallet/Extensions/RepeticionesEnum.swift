//
//  RepeticionesEnum.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 28/5/24.
//

import Foundation
enum Repetisiones: Int, Equatable, CaseIterable, Identifiable {
    case semanal = 7, quincenal = 15, mensual = 30
    var id: Self { self }
}
