//
//  Icons.swift
//  
//
//  Created by Johnnie Cheng on 24/10/22.
//

import SwiftUI
import UIKit

public enum Icons: String {
    
    case info = "icon-info"
    case imagePlaceholder = "imagePlaceholder"
    
    public func uiImage(_ color: Colors? = nil) -> UIImage {
        var image = UIImage(named: rawValue, in: .commonBundle, with: nil) ?? UIImage()
        if let color = color?.uiColor() {
            image = image.withRenderingMode(.alwaysTemplate)
                .withTintColor(color)
        }
        else {
            image = image.withRenderingMode(.alwaysOriginal)
        }
        
        return image
    }
    
}

extension UIImage {
    
    static func from(
        icon: Icons,
        color: Colors? = nil
    ) -> UIImage? {
        icon.uiImage(color)
    }
    
}