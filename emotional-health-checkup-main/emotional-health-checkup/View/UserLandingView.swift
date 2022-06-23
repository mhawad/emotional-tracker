//
//  UserLandingView.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 3/21/22.
//
import SwiftUI

struct UserLandingView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var sessionListViewModel: SessionListViewModel
    @EnvironmentObject var recordSessionViewModel: RecordSessionViewModel
    
    // MARK: BODY
    var body: some View {
        VStack{
            
            // MARK: - if sessions empty
            if sessionListViewModel.sessions?.isEmpty ?? false {
                GetStartedView()
                    .environmentObject(recordSessionViewModel)
                
                // MARK: - If sessions not empty
                
            } else {
                
                // MARK: - Session Graph Widget
                if sessionListViewModel.sessions != nil {
                    TimeLineView(sessions: sessionListViewModel.sessions!.reversed())
                        .padding(.horizontal, 8)
                        .padding(.top, 5)
                } else {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 40))
                }
                // MARK: - Session List Widget
                MiniListView()
                    .environmentObject(sessionListViewModel)
            }
            
            // MARK: - Record Button
            NavigationLink { // destination
                RecordSessionView()
                    .environmentObject(recordSessionViewModel)
            } label: {
                CustomButtonLabel(buttonLabel: "Record Session")
            }
            if sessionListViewModel.sessions?.isEmpty ?? false {
                Spacer()
            }
        }
    }
}

//struct UserLandingView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserLandingView()
//    }
//}
