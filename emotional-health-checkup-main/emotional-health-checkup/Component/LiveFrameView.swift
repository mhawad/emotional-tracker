//
//  LiveFrameView.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/23/22.
//

import SwiftUI

struct LiveFrameView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var sessionViewModel: RecordSessionViewModel
    
    //    var image: CGImage?
    // MARK: BODY
    var body: some View {
        
        Group {
            if let image = sessionViewModel.frame {
                GeometryReader { geo in
                    Image(
                        decorative: image,
                        scale: 1.0,
                        orientation: .upMirrored
                    ).resizable()
                        .scaledToFill()
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height)
                        .clipped()
                }
            } else {
                Color.black
            }
        }
        .ignoresSafeArea()
        .onAppear {
            sessionViewModel.startCamera()
        }
        .onDisappear {
            sessionViewModel.stopCamera()
        }
    }
}

//struct FrameView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiveFrameView()
//    }
//}
