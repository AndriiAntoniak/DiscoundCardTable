//
//  Protocols.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/16/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

class RotateImage{
    
    static func rotateImage(image:UIImage?)->UIImage? {
        if let originalImage = image {
            let rotateSize = CGSize(width: originalImage.size.height, height: originalImage.size.width)
            UIGraphicsBeginImageContextWithOptions(rotateSize, true, 2.0)
            if let context = UIGraphicsGetCurrentContext() {
                context.rotate(by: 90.0 * CGFloat(Double.pi) / 180.0)
                context.translateBy(x: 0, y: -originalImage.size.height)
                originalImage.draw(in: CGRect.init(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height))
                let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return rotatedImage!
            }
        }
        return nil
    }
}
