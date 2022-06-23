//
//  ViewExtensions.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 4/12/22.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
