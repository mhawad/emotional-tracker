//
//  TimeLineView.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 4/5/22.
//

import SwiftUI
import LineChartView
import FirebaseFirestore

struct TimeLineView: View {
    // MARK: PROPERTIES
    let calendar = Calendar(identifier: .gregorian)
    
    let dateFormatter = CustomDateFormatter.shared
    
    @State var showingHint = false
    var blurValue: Double {showingHint ? 3.0 : 0.0}
    
    var dates: [Date] = []
    var values: [Double] = []
    var labels: [String] = []
    
    init(sessions: [RecordModel]){
        
        var previousDate = Date.distantPast
        
        sessions.forEach { listedSession in
            
            let date = listedSession.timestamp.dateValue()
            
            let value = EmotionPrediction(
                happyConf: listedSession.happyConf,
                sadConf: listedSession.sadConf).emotionIndex * 100
            
            var label = dateFormatter.format(date: date) + "\n"
            
            if listedSession.comment.count < 30 {
                label += listedSession.comment
            } else {
                label += listedSession.comment.prefix(27) + "..."
            }
            
            // if same day, overwrite prev record in graph
            if calendar.isDate(date, inSameDayAs: previousDate) {
                dates[dates.count - 1] = date
                values[values.count - 1] = value
                labels[labels.count - 1] = label
            } else {
                // add after previous date and update previous date
                dates.append(date)
                values.append(value)
                labels.append(label)
                previousDate = date
            }
        }
    }
    // MARK: BODY
    var body: some View {
        Group {
            
            if dates.count > 1 {
                
                ZStack(alignment: .topTrailing) {
                    LineChartView(
                        lineChartParameters: LineChartParameters(
                            data: values,
                            dataTimestamps: dates,
                            dataLabels: labels,
                            labelColor: .mint.opacity(0.7),
                            secondaryLabelColor: .secondary,
                            labelsAlignment: .left,
                            dataPrecisionLength: 0,
                            indicatorPointColor: .mint,
                            indicatorPointSize: 10,
                            lineColor: .purple.opacity(0.7),
                            lineSecondColor: .mint,
                            lineWidth: 4,
                            dotsWidth: 3,
                            dragGesture: true,
                            hapticFeedback: true)
                    )
                    .background(Color(UIColor.systemBackground))
                    //                    .cornerRadius(20)
                    //                    .shadow(color: .secondary.opacity(0.65), radius: 8, x: 0, y: 0)
                    //                    .aspectRatio(1.5, contentMode: .fit)
                    .blur(radius: blurValue)
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("Emotional Record")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding([.top, .trailing], 16)
                            .foregroundColor(.indigo)
                            .blur(radius: blurValue)
                        Button { // action
                            withAnimation() {
                                showingHint.toggle()
                            }
                        } label: {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "info.circle")
                                    .padding()
                                    .foregroundColor(.gray)
                                if showingHint {
                                    HintBoxView()
                                }
                            }
                        }
                        
                    }
                }
            } else {
                GeometryReader { geo in
                    EmptyGraphPlaceholder()
                    //                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                }
            }
        }
        .cornerRadius(20)
        .shadow(color: .secondary.opacity(0.65), radius: 8, x: 0, y: 0)
        .aspectRatio(1.5, contentMode: .fit)
    }
}

struct TimeLineView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let sessions = [
            RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date.now), happyConf: 0.8, sadConf: 0.0, comment: "This is a really long com ment without intentional line breaks"),
            RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date.now + 3600 * 10), happyConf: 0.5, sadConf: 0.0, comment: "This is a really long comment without intentional line breaks"),
            RecordModel(id: "id", userID: "uid", timestamp: Timestamp(date: Date.now + 360_000), happyConf: 0.0, sadConf: 0.0, comment: "This is a shorter comment"),
        ]
        
        TimeLineView(sessions: sessions)
            .padding()
        //            .preferredColorScheme(.dark)
        
    }
}

struct HintBoxView: View {
    // MARK: BODY
    var body: some View {
        HStack {
            Text("Try dragging across the line!\n( Tap to close )")
                .foregroundColor(.white)
                .padding(30)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.25))
                .background(Color("customMint").opacity(0.5))
        }
    }
}
