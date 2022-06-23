//
//  MiniListRow.swift
//  happy-tracker
//
//  Created by Mirna Helmy on 3/24/22.
//



import SwiftUI
import FirebaseFirestore

struct MiniListRow: View {
    // MARK: PROPERTIES
    
    var backgroundOpacity: Double
    var session: RecordModel
    var formatter = CustomDateFormatter.shared
    var emotionLabel: String
    var emotionIndexLabel: String
    
    init(session: RecordModel, backgroundOpacity: Double) {
        self.session = session
        self.backgroundOpacity = backgroundOpacity
        let emotion = EmotionPrediction(happyConf: session.happyConf, sadConf: session.sadConf)
        emotionLabel = emotion.emotionIndex > 0.5 ? "Happy" : "Sad"
        emotionIndexLabel = String(format: "( %.0f )", emotion.emotionIndex*100)
    }
    // MARK: BODY
    var body: some View {
        ZStack {
            //            Color.mint.opacity(backgroundOpacity)
            Color("customMint").opacity(backgroundOpacity)
            HStack(alignment: .top, spacing: 0.0) {
                
                VStack(alignment: .leading) {
                    Text(formatter.format(date: session.timestamp.dateValue()))
                        .fontWeight(.thin)
                        .frame(width: 110, alignment: .leading)
                    
                    HStack {
                        Text(emotionLabel)
                            .fontWeight(.bold)
                        //.frame(width: 70, alignment: .leading)
                        
                        //Spacer()
                        
                        Text(emotionIndexLabel)
                            .fontWeight(.thin)
                        //.frame(alignment: .trailing)
                        
                        Spacer()
                    }
                    .frame(width:110)
                }
                .padding(.horizontal)
                
                Rectangle()
                    .frame(width: 0.5)
                    .foregroundColor(.primary.opacity(0.5))
                
                Text(session.comment)
                    .padding(.horizontal)
                
                Spacer()
                
            }
            .padding(.vertical)
        }
    }
}

struct MiniListRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            MiniListRow(session: RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date()), happyConf: 0.8, sadConf: 0.0, comment: "This is a really long com ment without intentional line breaks"), backgroundOpacity: 0.2)
            MiniListRow(session: RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date()), happyConf: 0.0, sadConf: 0.0, comment: "This is a shorter comment"), backgroundOpacity: 0.1)
            MiniListRow(session: RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date()), happyConf: 0.6, sadConf: 0.0, comment: "This is a really long comment without intentional line breaks"), backgroundOpacity: 0.2)
        }
    }
}
