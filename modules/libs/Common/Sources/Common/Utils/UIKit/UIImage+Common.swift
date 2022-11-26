//
//  UIImage+Common.swift
//
//  Created by Johnnie Cheng on 29/4/21.
//

import UIKit

public extension UIImage {
    
    convenience init(
        color: UIColor,
        size: CGSize = CGSize(width: 1, height: 1)
    ) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let cgImage = image?.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
    
}

// MARK: - Resize
extension UIImage {
    
    func resize(width: CGFloat) -> UIImage {
        let height = (width / self.size.width) * self.size.height
        return resize(to: CGSize(width: width, height: height))
    }

    func resize(height: CGFloat) -> UIImage {
        let width = (height / self.size.height) * self.size.width
        return resize(to: CGSize(width: width, height: height))
    }

    func resize(to size: CGSize) -> UIImage {
        let widthRatio  = size.width / self.size.width
        let heightRatio = size.height / self.size.height
        var updateSize = size
        if widthRatio > heightRatio {
            updateSize = CGSize(
                width: self.size.width * heightRatio,
                height: self.size.height * heightRatio
            )
        } else if heightRatio > widthRatio {
            updateSize = CGSize(
                width: self.size.width * widthRatio,
                height: self.size.height * widthRatio
            )
        }
        
        UIGraphicsBeginImageContextWithOptions(updateSize, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: updateSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
}
