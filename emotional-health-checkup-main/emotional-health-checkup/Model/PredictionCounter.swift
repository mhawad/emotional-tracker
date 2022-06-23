//
//  PredictionCounter.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/29/22.
//

import Foundation
import Vision

class PredictionCounter {
    
    private var count = 0
    private var sumHappyConfidence = 0.0
    private var sumSadConfidence = 0.0
    
    func addBuffer(cvpBuffer: CVPixelBuffer?) {
        if let cvpBuffer = cvpBuffer {
            self.count += 1
            ImageClassifier.classifyBuffer(cvpBuffer: cvpBuffer) { bufferPrediction in
                self.sumHappyConfidence += bufferPrediction.happyConfidence
                self.sumSadConfidence += bufferPrediction.sadConfidence
            }
        }
    }
    
    func getTotalHappyAndSad() -> (Double, Double) {
        return (sumHappyConfidence / Double(count), sumSadConfidence / Double(count))
    }
    
}
