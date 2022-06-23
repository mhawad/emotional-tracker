//
//  ImageClassifier.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/24/22.
//

import Vision
import Combine

class ImageClassifier {
    
    static let shared = createImageClassifier()
    
    private init() {}
    
    // apple sample code
    // https://developer.apple.com/documentation/vision/classifying_images_with_vision_and_core_ml
    static func createImageClassifier() -> VNCoreMLModel {
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()
        
        // Create an instance of the image classifier's wrapper class.
        let imageClassifierWrapper = try? EmotionRecognitionClassifierHNS(configuration: defaultConfig)
        
        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }
        
        // Get the underlying model instance.
        let imageClassifierModel = imageClassifier.model
        
        // Create a Vision instance using the image classifier's model instance.
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        return imageClassifierVisionModel
    }
    
    static func classifyBuffer(cvpBuffer: CVPixelBuffer?, action: @escaping (BufferPrediction) -> Void) {
        let imageClassificationRequest = VNCoreMLRequest(model: ImageClassifier.shared) {
            successfulRequest, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let results = successfulRequest.results as? [VNClassificationObservation]
            else { return }
            
            var happyConf = 0.0
            var sadConf = 0.0
            
            for result in results {
                if result.identifier == "happy" {
                    happyConf = Double(result.confidence)
                } else if result.identifier == "sad" {
                    sadConf = Double(result.confidence)
                }
            }
            
            let bufferPred = BufferPrediction(happyConfidence: happyConf, sadConfidence: sadConf)
            action(bufferPred)
        }
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        
        
        guard let cvpBuffer = cvpBuffer else {
            return
        }
        let handler = VNImageRequestHandler(cvPixelBuffer: cvpBuffer)
        
        do {
            try handler.perform([imageClassificationRequest])
        } catch {
            print(error)
        }
    }
}
