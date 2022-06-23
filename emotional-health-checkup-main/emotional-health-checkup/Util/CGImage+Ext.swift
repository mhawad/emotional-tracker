//
//  CGImage+Ext.swift
//  happy-tracker
//
//  Created by Patrick Fuller on 3/23/22.
//

import VideoToolbox

extension CGImage {
    
    static func create(from buffer: CVPixelBuffer?) -> CGImage? {
        
        guard let buffer = buffer else {return nil}
        
        var cgImage: CGImage?
        
        VTCreateCGImageFromCVPixelBuffer(buffer, options: nil, imageOut: &cgImage)
        return cgImage
    }
}
