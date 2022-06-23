//
//  CustomButton.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/21/22.
//

import SwiftUI

struct CustomButton: View {
    // MARK: PROPERTIES
    var buttonLabel: String
    
    var action: () -> Void
    // MARK: BODY
    var body: some View {
        Button {
            // action
            action()
            
        } label: {
            CustomButtonLabel(buttonLabel: buttonLabel)
        }
    }
}

struct CustomButtonLabel: View {
    // MARK: PROPERTIES
    var buttonLabel: String
    // MARK: BODY
    var body: some View {
        Text(buttonLabel)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(height: 45)
            .font(.title2)
            .padding(.horizontal)
            .background(Color("medium"))
            .clipShape(Capsule())
    }
}
