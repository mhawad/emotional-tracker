//
//  LoginView.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/21/22.
//

import SwiftUI

struct LoginView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email = ""
    @State var password = ""
    
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
                    
                    Text("Log In")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding(.bottom)
                    
                    
                    
                    // Email and pass section
                    // email label
                    CustomAuthLabel(label: "Email")
                    
                    // email input
                    CustomTextField(placeholder: "enter email", inputText: $email, isSecure: false)
                    
                    
                    // Pass label
                    CustomAuthLabel(label: "Password")
                    
                    // Pass input
                    CustomTextField(placeholder: "enter password", inputText: $password, isSecure: true)
                        .onSubmit {viewModel.login(withEmail: email, password: password)
                        }
                    
                }
                .padding(.leading, 20)
                .padding(.bottom, 40)
            }
            // Login button (roundy Button)
            CustomButton(buttonLabel: "Login") {
                // signin action calls login func
                viewModel.login(withEmail: email, password: password)
                
            }
            
            .alert("Cannot Login: \(viewModel.authError?.localizedDescription ?? "yeet")", isPresented: $viewModel.isError) {
                Button("OK", role: .cancel){
                    viewModel.isError = false
                }
            }
            
            Spacer()
            
            // newUser->Register (texty button)
            NavigationLink{
                RegisterView()
                
                //.navigationBarHidden(true)
            } label: {
                HStack {
                    Text("New user?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Text("Sign up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom)
            .foregroundColor(Color(.systemBlue))
            
        }
        .background(Color("pale").opacity(0.2))
        .onDisappear {
            print(" Disappearing Login view; disabled: \(viewModel.isDisabled)")
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
