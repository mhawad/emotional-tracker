//
//  SessionDoneView.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/28/22.
//

import SwiftUI

struct SessionDoneView: View {
    // MARK: PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionViewModel: RecordSessionViewModel
    
    // MARK: BODY
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                
                Text("Thank You!")
                    .font(.title2)
                Text("Your session is complete")
                
                Button {
                    // action
                    sessionViewModel.resetSession()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Return Home")
                        .fontWeight(.bold)
                        .padding(8)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3))
                }
                
            }
            
            .padding()
            .background(Color("medium"))
            
            .cornerRadius(20)
            
            .padding(2)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(
                    lineWidth: 5))
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct SessionDoneView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDoneView()
    }
}
