//
//  SideMenuOptionRowView.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 3/22/22.
//
import SwiftUI

struct SideMenuOptionRowView: View {
    // MARK: PROPERTIES
    let viewModel: SideMenuOption
    // MARK: BODY
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
            
            Text(viewModel.menuOption)
            //.foregroundColor(.black)
            
            Spacer()
        }
        .frame(height:40)
        .padding(.horizontal)
    }
}

struct SideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionRowView(viewModel: .profile)
    }
}
