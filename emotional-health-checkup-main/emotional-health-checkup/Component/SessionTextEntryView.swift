//
//  RecordingDoneView.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/28/22.
//

import SwiftUI

struct SessionTextEntryView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var sessionViewModel: RecordSessionViewModel
    
    @State var description = ""
    var placeholder = "5-20 words describing your feelings"
    // MARK: BODY
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                
                ZStack(alignment: .topLeading) {
                    
                    Color(UIColor.systemBackground)
                    
                    // Vanishing placeholder
                    if description == "" {
                        Text(placeholder)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                    
                    TextEditor(text: $description)
                        .padding(8)
                        .foregroundColor(Color.primary)
                }
                .onAppear {
                    UITextView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITextView.appearance().backgroundColor = nil
                }
                
                HStack {
                    Button { // action
                        sessionViewModel.resetSession()
                    } label: {
                        Text("Cancel Entry")
                            .padding()
                    }
                    
                    Rectangle()
                        .frame(
                            minWidth: 1,
                            idealWidth: 1,
                            maxWidth: 1,
                            minHeight: 20,
                            idealHeight: 20,
                            maxHeight: 40)
                        .foregroundColor(.white.opacity(0.5))
                    
                    Button { // action
                        sessionViewModel.submitSession(comment: description)
                    } label: {
                        Text("Submit Entry")
                            .fontWeight(.semibold)
                            .padding()
                    }
                }
            }
            
            .background(Color("medium"))
            .foregroundColor(.white)
            
            .frame(minHeight: 200, idealHeight: 400, maxHeight: 400)
            .cornerRadius(20)
            
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2))
            .foregroundColor(.white)
            .padding(30)
        }
    }
}

struct RecordingDoneView_Previews: PreviewProvider {
    static var previews: some View {
        SessionTextEntryView()
            .preferredColorScheme(.dark)
            .environmentObject(RecordSessionViewModel())
    }
}
