//
//  MiniListView.swift
//  happy-tracker
//
//  Created by Mirna Helmy on 3/24/22.
//


import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct MiniListView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var sessionListViewModel: SessionListViewModel
    @State var showingOldestFirst = true
    
    
    var sessions: [RecordModel] {
        if let sessions = sessionListViewModel.sessions {
            if showingOldestFirst {
                return sessions
            } else {
                return sessions.reversed()
            }
        } else {
            return []
        }
    }
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottom){
            
            VStack(spacing: 0) {
                HStack{
                    Text("Your Checkups")
                        .padding()
                        .font(.headline)
                    
                    
                    Picker("Recent", selection: $showingOldestFirst) {
                        Text("Recent").tag(true)
                        Text("Oldest").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                }
                
                
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 4) {
                        ForEach(Array(zip(sessions.indices, sessions)), id: \.0)
                        {index, listedSession in
                            
                            MiniListRow(
                                session: listedSession,
                                backgroundOpacity: index % 2 == 0 ? 0.1 : 0.3)
                        }
                    }
                }
                
            }
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                )
                .opacity(0.5)
                .ignoresSafeArea()
                .frame(height: 50)
                .allowsHitTesting(false)       
        }
        
    }
}


//struct MiniListView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let sessions = [
//            RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date()), happyConf: 8.0, sadConf: 0.0, comment: "This is a really long com ment without intentional line breaks"),
//            RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date()), happyConf: 0.0, sadConf: 0.0, comment: "This is a shorter comment"),
//            RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date()), happyConf: 6.0, sadConf: 0.0, comment: "This is a really long comment without intentional line breaks")]
//        MiniListView(toggleIsOn: toggleIsOn, sessions: sessions)
//
//        //            .preferredColorScheme(.dark)
//    }
//}
