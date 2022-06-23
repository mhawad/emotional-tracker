//
//  EmptyGraphPlaceholder.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 4/12/22.
//

import SwiftUI

struct EmptyGraphPlaceholder: View {
    // MARK: PROPERTIES
    @State var showingHint: Bool = false
    // MARK: BODY
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .foregroundColor(.gray)
                    Text("Your progress will appear here.")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary.opacity(0.8))
                    Text("Please record again tomorrow to visualize your progress.")
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
                .blur(radius: showingHint ? 3 : 0)
                Spacer()
            }
            // Z-layer with info button
            
            VStack {
                Button {
                    withAnimation { showingHint.toggle() }
                } label: {
                    HStack {
                        if showingHint {
                            HintView()
                        } else {
                            Spacer()
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                    }
                }
                Spacer()
            }
        }
        .background(Color(UIColor.systemBackground).opacity(0.8))
        .background(
            LinearGradient(
                colors: [
                    Color(UIColor.systemBackground),
                    Color(UIColor.systemBackground),
                    Color(UIColor.systemBackground),
                    .purple,
                    Color("customMint"),
                    Color(UIColor.systemBackground),
                    Color(UIColor.systemBackground),
                    Color(UIColor.systemBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    struct HintView: View {
        // MARK: BODY
        var body: some View {
            HStack {
                Spacer()
                VStack {
                    Text("Progress is graphed after recording over multiple days.")
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    Text("Newer sessions on the same day replace older ones in the graph.")
                }
                Spacer()
            }
            .padding(.vertical, 30)
            //            .padding(.horizontal)
            .multilineTextAlignment(.center)
            .foregroundColor(.primary)
            //            .background(.gray.opacity(0.25))
            .background(Color("customMint").opacity(0.25))
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .padding(.vertical)
            .padding(.horizontal, 8)
        }
    }
}

struct EmptyGraphPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        EmptyGraphPlaceholder()
            .ignoresSafeArea()
        //            .preferredColorScheme(.dark)
    }
}

