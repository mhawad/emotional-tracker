//
//  happy_trackerApp.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/21/22.
//

import SwiftUI
import Firebase

@main
struct emotional_health_checkupApp: App {
    // MARK: PROPERTIES
    @StateObject var viewModel = AuthViewModel()
    
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("inOrder") private var inOrder = true
    
    init() {
        
        FirebaseApp.configure()
        
        //try? Auth.auth().signOut()
    }
    // MARK: BODY
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                //.environmentObject(viewModel)
            }
            .navigationViewStyle(.stack)
            .environmentObject(viewModel)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationViewStyle(.stack)
        }
        
    }
}
