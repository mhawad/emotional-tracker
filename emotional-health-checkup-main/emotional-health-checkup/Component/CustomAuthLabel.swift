//
//  CustomAuthLabel.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/21/22.
//

import SwiftUI

struct CustomAuthLabel: View {
    // MARK: PROPERTIES
    let label: String
    // MARK: BODY
    var body: some View {
        Text(label)
            .fontWeight(.bold)
    }
}

struct CustomAuthLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomAuthLabel(label: "label")
    }
}
