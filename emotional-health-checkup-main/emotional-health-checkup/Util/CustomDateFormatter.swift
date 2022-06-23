//
//  CustomDateFormatter.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 4/5/22.
//

import Foundation

struct CustomDateFormatter {
    let dateFormatter = DateFormatter()
    
    static let shared = CustomDateFormatter()
    
    private init() {
        dateFormatter.dateFormat = "MMM d, yyyy"
    }
    
    func getShared() {
        //        return self.sh
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
