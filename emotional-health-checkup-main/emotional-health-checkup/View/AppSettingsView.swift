//
//  AppSettingsView.swift
//  happy-tracker
//
//  Created by Alexander Davila-Wollheim on 3/22/22.
//
import SwiftUI

struct AppSettingsView: View {
    // MARK: PROPERTIES
    //@Binding var isDarkMode: Bool
    //@State var preferredColorScheme: ColorScheme = .light
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .top) {
            Color("pale")
                .ignoresSafeArea()
            
            VStack {
                Group{
                    Image(systemName: "gear")
                        .frame(width: 110, height: 110)
                        .font(.system(size: 100))
                        .foregroundColor(Color("medium"))
                    
                    Text("App Settings")
                        .font(.system(size: 40))
                }
                
                Spacer()
                
                //                if changeColor {
                //                    Image(systemName: "switch.2")
                //                        .font(.system(size: 50))
                //                }
                
                VStack(alignment: .leading) {
                    Text("Toggle Color Scheme")
                        .font(.system(size: 25))
                        .padding()
                    //                    Toggle("Change Color Theme", isOn: $isDarkMode)
                    //                        .padding()
                    Picker("Color Mode", selection: $isDarkMode) {
                        Text("Light")
                            .tag(false)
                        Text("Dark")
                            .tag(true)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                }
                
                Spacer()
            }
        }
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
