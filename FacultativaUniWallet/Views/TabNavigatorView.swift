//
//  TabNavigatorView.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import SwiftUI

struct TabNavigatorView: View {
    
    @Binding var selection: AppScreen?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(AppScreen.allCases) { screen in
                    screen.destination
                        .tag(screen as AppScreen?)
                    //                        .tabItem { screen.label }
                }
            }
            ZStack{
                HStack{
                    ForEach((AppScreen.allCases), id: \.self){ item in
                        Button{
                            selection = item
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selection == item))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.cyan.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
    }
}
extension  TabNavigatorView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 50, height: 60)
        .background(isActive ? .cyan.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}
//
//#Preview {
//    TabNavigatorView(selection: .constant(.found))
//}
