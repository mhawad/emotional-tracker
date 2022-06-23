//
//  CustomTextField.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/21/22.
//

import SwiftUI

struct CustomTextField: View {
    // MARK: PROPERTIES
    let placeholder: String
    @Binding var inputText: String
    let isSecure: Bool
    // MARK: BODY
    var body: some View {
        
        
        Group {
            if isSecure {
                SecureField(placeholder, text: $inputText)
                
                
            } else {
                TextField(placeholder, text: $inputText)
                
                
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("medium").opacity(0.5), lineWidth: 3)
        )
        .padding(.trailing)
        
    }
}
