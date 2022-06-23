//
//  RegisterView.swift
//  happy-tracker
//
//  Created by Mirna Helmy on 3/21/22.
//

import SwiftUI


struct RegisterView: View {
    // MARK: PROPERTIES
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
 
    // MARK: BODY
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack {
                Spacer()
                Text("Emotional Health")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Check-up")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                // Logo
                LogoView()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding(.bottom)
                        .padding(.leading)
                    //name input
                    
                    VStack(alignment: .leading){
                        CustomAuthLabel(label: "Name")
                        CustomTextField(placeholder: "enter name",
                                        inputText: $name,
                                        isSecure: false)
                        
                        //email input
                        CustomAuthLabel(label: "Email")
                        
                        CustomTextField(placeholder: "enter email",
                                        inputText: $email,
                                        isSecure: false)
                        
                        
                        //password input
                        
                        CustomAuthLabel(label: "Password")
                        
                        CustomTextField(placeholder: "enter password",
                                        inputText: $password,
                                        isSecure: true)
                        
                        // Confirm password
                        CustomAuthLabel(label: "Confirm Password")
                        
                        CustomTextField(placeholder: "enter password",
                                        inputText: $confirmedPassword,
                                        isSecure: true)
                        .onSubmit {viewModel.register(withEmail: email, password: password, confirmedPassword: confirmedPassword, name: name)
                        }
                        
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 40)
                }
                
                // Login button (roundy Button)
                CustomButton(buttonLabel: "Register") {
                    // button action
                    viewModel.register(withEmail: email,
                                       password: password,
                                       confirmedPassword: confirmedPassword,
                                       name: name)
                }
            }
            
            .alert("Cannot Register: \(viewModel.authError?.localizedDescription ?? "yeet")", isPresented: $viewModel.isError) {
                Button("OK", role: .cancel){
                    viewModel.isError = false
                }
            }
            
            
            Spacer()
            
            // newUser->Register (texty button)
            
        }
        .background(Color("pale").opacity(0.2))
        .onTapGesture {
            self.hideKeyboard()
        }
        
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
