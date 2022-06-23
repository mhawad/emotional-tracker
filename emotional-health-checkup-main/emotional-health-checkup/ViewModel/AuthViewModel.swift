//
//  AuthViewModel.swift
//  happy-tracker
//
//  Created by Mirna Helmy on 3/24/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    @Published var isDisabled: Bool = false
    
    private let userService = UserService()
    var authError: Error?
    
    @Published var isError: Bool = false
    
    init() {
        
        self.userSession = Auth.auth().currentUser
        
        if let userSessionId = userSession?.uid {
            self.userService.fetchUser(withUid: userSessionId) { user, error in
                if let error = error {
                    self.isDisabled = true
                    print("Error getting user in init: \(error.localizedDescription)")
                }
                self.currentUser = user
            }
        }
    }
    // MARK: FUNCTIONS
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to Sign in with error \(error.localizedDescription)")
                
                self.setError(error)
                
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            //FETCH USER:::::::::::::::::::::::::::
            self.userService.fetchUser(withUid: user.uid) { user, error in
                
                // This closure will still happen even user nil
                if let error = error {
                    print("Error getting user on login: \(error.localizedDescription)")
                    self.isDisabled = true
                }
                self.currentUser = user
            }
        }
    }
    
    func register(withEmail email: String, password: String, confirmedPassword: String, name: String) {
        
        // Assert name not empty
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard trimmedName != "" else {
            setError(AuthError.emptyName)
            return
        }
        
        // Assert passwords match
        guard password == confirmedPassword else {
            setError(AuthError.passwordConfirmFailure)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                self.setError(error)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            // Set Current user with userModelObj and then use obj to set data for document w docId = uid
            self.currentUser = UserModel(email: email, name: name)
            
            do {
                try Firestore.firestore().collection("users").document(user.uid).setData(from: self.currentUser!)
                print("Successfully stored user account with document reference")
            } catch {
                print("Error storing user account: \(error)")
            }
        }
    }
    
    func setError(_ error: Error) {
        self.authError = error
        self.isError = true
    }
    
    func signOut() {
        //logs out on frontend, send us back to login
        userSession = nil
        //logs out on backend
        try? Auth.auth().signOut()
    }
}

enum AuthError: Error {
    
    case emptyName
    case passwordConfirmFailure
    
}
// MARK: EXTENSION

extension AuthError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .emptyName:
            
            return NSLocalizedString(
                "The name cannot be empty.",
                comment: "Invalid Name"
            )
            
        case .passwordConfirmFailure:
            return NSLocalizedString(
                "Your passwords must match.",
                comment: "Passwords Match Error"
            )
        }
    }
}
