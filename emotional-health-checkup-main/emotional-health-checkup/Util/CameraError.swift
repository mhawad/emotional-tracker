//
//  CameraError.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/23/22.
//

import Foundation
import AVFoundation

enum CameraError {
    
    case deniedAuthorization
    case unknownAuthorization
    case restrictedAuthorization
    case cameraUnavailable
    case cannotAddInput
    case cannotAddOutput
    case createCaptureInput(_ error: Error)
    
    public var description: String {
        switch self {
        case .deniedAuthorization:
            return "Authorization denied; please check privacy permissions"
        case .unknownAuthorization:
            return "Authorization unknown; please check privacy permissions"
        case .restrictedAuthorization:
            return "Authorization restricted; please check privacy permissions"
        case .cameraUnavailable:
            return "Camera unavailable"
        case .cannotAddInput:
            return "Cannot add input"
        case .cannotAddOutput:
            return "Cannout add output"
        case .createCaptureInput(let rootError):
            return "Error capturing input: \(rootError.localizedDescription)"
        }
    }
}
