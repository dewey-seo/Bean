//
//  BeanImage.swift
//  bean
//
//  Created by dewey seo on 03/07/2021.
//

import Foundation
import UIKit

extension UIImage {
    public func convertGrayScale(image: UIImage ) -> UIImage? {
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        let resultWidth: CGFloat = 320
        let resultHeight = resultWidth * image.size.height / image.size.width
        let resultRect: CGRect = CGRect(x: 0, y: 0, width: resultWidth, height: resultHeight)
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        
        if let cgImage = image.cgImage,
           let context = CGContext(
            data: nil, width: Int(resultWidth), height: Int(resultHeight),
            bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue
           )
        {
            context.interpolationQuality = .low
            context.draw(cgImage, in: resultRect)
            
            if let resultCgImage = context.makeImage() {
                return UIImage(cgImage: resultCgImage)
            }
        }
        
        return nil
    }
}

