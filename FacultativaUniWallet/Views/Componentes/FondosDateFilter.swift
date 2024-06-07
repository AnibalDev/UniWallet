//
//  FondosDateFilter.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 31/5/24.
//

import SwiftUI

struct FondosDateFilter: View {
    
    @State var date = Date()
    @Binding var selectedRange: Int
    
    var body: some View {
        HStack {
            Picker("What is your favorite color?", selection: $selectedRange) {
                Text("7D").tag(7)
                Text("15D").tag(15)
                Text("1M").tag(30)
            }
            .pickerStyle(.segmented)
        }
    }
}


//#Preview {
//    @State var selectedRange = 0
//    FondosDateFilter( selectedRange: $selectedRange)
//}
