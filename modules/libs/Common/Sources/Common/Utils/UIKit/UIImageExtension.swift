//
//  UIImageExtension.swift
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
