//
//  UserService.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 3/30/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completeSettingUser: @escaping(UserModel?, Error?)->Void){
        
        var fetchError: Error?
        var user: UserModel?
        
        Firestore.firestore().collection("users").document(uid).getDocument{snapshot, _ in
            
            if let snapshot = snapshot  {
                do {
                    user = try snapshot.data(as: UserModel.self)
                } catch {
                    fetchError = error
                }
            } else {
                fetchError = UserServiceError.snapshotError
            }
            completeSettingUser(user, fetchError)
        }
    }
}

enum UserServiceError: Error {
    case snapshotError
}

// MARK: EXTENSION
extension UserServiceError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .snapshotError:
            
            return NSLocalizedString(
                "Unable to retreive snapshot of user data.",
                comment: "Snapshot error"
            )
        }
    }
}
