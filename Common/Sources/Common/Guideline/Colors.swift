//
//  Colors.swift
//  
//
//  Created by Johnnie Cheng on 22/10/22.
//

import SwiftUI
import UIKit

/// Pre-defined semantic colors. If need to override, create "Colors" assets in main app with same color names
public enum Colors: String {
    
    case primaryColor = "common-primaryColor"
    case secondaryColor = "common-secondaryColor"
    
    case titleColor = "common-titleColor"
    case subtitleColor = "common-subtitleColor"
    case primaryLabel = "common-primaryLabel"
    
    case backgroundColor = "common-backgroundColor"
    case shadow = "common-shadow"
    
    case infoBlue = "common-info-blue"
    
    /// get dynamic color depends on the light/dark mode
    /// - Parameters:
    ///   - opacity: opacity from 0.0-1.0
    ///   - bundle: if a  non-nil value is passed, color will load from provided bundle only. Otherwise, will try to load from main bundle at first, if it is NOT existing, will loan from .module
    ///
    /// - Returns: color
    public func dynamicColor(
        _ opacity: Double = 1,
        inBundle bundle: Bundle? = nil
    ) -> Color {
        var color: Color
        if let bundle = bundle {
            color = Color(rawValue, bundle: bundle)
        } else {
            if let uicolor = UIColor(named: rawValue, in: .main, compatibleWith: nil) {
                color = Color(uicolor)
            } else {
                color = Color(rawValue, bundle: .module)
            }
        }
        
        return color.opacity(opacity)
    }
    
    public func uiColor(
        _ opacity: Double = 1,
        inBundle bundle: Bundle? = nil
    ) -> UIColor {
        UIColor(dynamicColor(opacity, inBundle: bundle))
    }

}

extension UIColor {
    
    static func from(
        color: Colors,
        opacity: Double = 1
    ) -> UIColor {
        color.uiColor(opacity)
    }
    
}
