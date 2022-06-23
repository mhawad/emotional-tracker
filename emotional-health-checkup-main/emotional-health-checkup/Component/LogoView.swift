//
//  LogoView.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/21/22.
//

import SwiftUI

struct LogoView: View {
    
    // MARK: BODY
    var body: some View {
        
        Image(systemName: "brain.head.profile")
            .font(.system(size: 70))
            .foregroundColor(Color("pale"))
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 2,
                            lineCap: .round,
                            lineJoin: .miter,
                            miterLimit: 0,
                            dash: [10,5],
                            dashPhase: 0))
            )
            .foregroundColor(Color("pale"))
            .padding()
            .background(Color("medium"))
            .cornerRadius(15)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
    }
}
