//
//  ProfileView.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 3/22/22.
//
import SwiftUI

struct ProfileView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // MARK: BODY
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack {
                Spacer()
                
                Image(systemName: "person.circle")
                    .frame(width: 110, height: 110)
                    .font(.system(size: 100))
                    .foregroundColor(Color("medium"))
                
                Text("\(user.name.capitalized)'s Profile")
                    .font(.system(size: 40))
                
                ProfileInfoView(text: "\(user.name.capitalized)", imageName: "figure.walk")
                
                ProfileInfoView(text: "\(user.email)", imageName: "envelope.fill")
                
                Spacer()
            }
            .background(Color("pale").opacity(0.2))
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
