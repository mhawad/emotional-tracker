//
//  SessionService.swift
//  happy-tracker
//
//  Created by Mirna Helmy on 3/28/22.
//

import Firebase
import FirebaseFirestore

struct SessionService {
    
    static func uploadSession(session: RecordModel) {
        let sessionDocumentRef: DocumentReference?
        
        sessionDocumentRef = try? Firestore.firestore().collection("sessions").addDocument(from: session)
        if let sessionDocumentRef = sessionDocumentRef {
            print("SESSION SERVICE - successfully uploaded document: \(sessionDocumentRef.documentID)")
        } else {
            print("Error handling session entry")
        }
    }
}
