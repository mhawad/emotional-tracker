//
//  SideMenuView.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 3/21/22.
//
import SwiftUI

struct SideMenuView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var logoutAlert: Bool = false
    
    @State private var disabled = true
    
    @Binding var showThis: Bool
    
    // MARK: BODY
    var body: some View {
        //if successfully set of the usermodel
        
        VStack(alignment: .leading, spacing: 35) {
            VStack(alignment: .leading){
                Button{
                    withAnimation(.easeIn){
                        showThis.toggle()
                    }
                } label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("medium"))
                }
                if authViewModel.currentUser != nil {
                    Text(authViewModel.currentUser!.name.capitalized)
                        .font(.headline)
                }else{
                    Text("ERROR")
                        .font(.headline)
                }
                
                if authViewModel.currentUser != nil {
                    Text(authViewModel.currentUser!.email)
                        .font(.caption)
                        .foregroundColor(.gray)
                }else{
                    Text("ERROR")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            .padding(.leading)
            
            ForEach(SideMenuOption.allCases, id: \.rawValue) { viewModel in
                if viewModel == .profile {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }.disabled(authViewModel.isDisabled)
                } else if viewModel == .appSettings{
                    NavigationLink{
                        AppSettingsView()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }.disabled(authViewModel.isDisabled)
                } else if viewModel == .logout {
                    Button {
                        logoutAlert = true
                        //authViewModel.signOut()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                    .alert(isPresented: $logoutAlert) {
                        Alert(
                            title: Text("Confirm Log Out"),
                            message: Text("Are you sure you want to Log Out?"), primaryButton: .destructive(Text("Logout"), action: {
                                authViewModel.signOut()
                            }), secondaryButton: .cancel())
                    }
                    
                } else {
                    SideMenuOptionRowView(viewModel: viewModel)
                }
                
            }
            
            Spacer()
        }
        .background(Color(UIColor.systemBackground))
        //================END OF ENABLED SIDEMENU VSTACK================
        
        //====================END OF IF=================
        
        //====================END OF ELSE=================
    }
    //====================END OF BODY=================
}
//====================END OF VIEW=================

//struct SideMenuView_Previews: PreviewProvider {
//    @State var previewBindingBool = true
//    static var previews: some View {
//        SideMenuView(showThis: $previewBindingBool)
//            //.environmentObject(AuthViewModel())
//    }
//}
