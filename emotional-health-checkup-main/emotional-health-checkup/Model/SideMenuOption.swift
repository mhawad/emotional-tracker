//
//  SideMenuOption.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 3/21/22.
//
import Foundation
import IOSurface

enum SideMenuOption: Int, CaseIterable {
    case profile
    case appSettings
    case logout
    
    var menuOption: String {
        switch self {
        case .profile: return "Profile"
        case .appSettings: return "App Settings"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .appSettings: return "gear"
        case .logout: return "arrow.left.square"
        }
    }
}
