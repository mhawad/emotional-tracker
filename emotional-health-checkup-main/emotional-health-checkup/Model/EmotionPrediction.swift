//
//  EmotionPrediction.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/25/22.
//

import Foundation

struct EmotionPrediction {
    
    let emotionIndex: Double
    
    var emotion: String {
        if emotionIndex < 0.50 {
            return "sad"
        } else {
            return "happy"
        }
    }
    
    init(happyConf: Double, sadConf: Double) {
        emotionIndex = 0.5 + 0.5 * (happyConf - sadConf)
    }
}
