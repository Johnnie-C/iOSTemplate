//
//  Colors.swift
//  
//
//  Created by Johnnie Cheng on 22/10/22.
//

import SwiftUI
import UIKit

/// Pre-defined semantic colors. If need to override, create "Colors" assets in main app with same color names
public enum Colors {
    
    case primaryColor
    case secondaryColor
    
    case titleColor
    case subtitleColor
    case primaryLabel
    
    case backgroundColor
    case shadow
    case divider
    
    case infoBlue
    case errorRed
    
    /// an example for using custom color in module
    ///
    /// define colors for convenience use
    ///
    ///     extension Colors {
    ///         static var myColorInModule: Colors {
    ///             .custom(name: "myColor", bundle: .myModuleBundle)
    ///         }
    ///     }
    ///
    /// use color
    ///
    ///     "text".styled(font: .body(), color: .myColorInModule)
    ///
    case custom(name: String, bundle: Bundle = .main)
    
    private var name: String {
        switch self {
        case .primaryColor:
            return "common-primaryColor"
        case .secondaryColor:
            return "common-secondaryColor"
        case .titleColor:
            return "common-titleColor"
        case .subtitleColor:
            return "common-subtitleColor"
        case .primaryLabel:
            return "common-primaryLabel"
        case .backgroundColor:
            return "common-backgroundColor"
        case .shadow:
            return "common-shadow"
        case .divider:
            return "common-divider"
        case .infoBlue:
            return "common-info-blue"
        case .errorRed:
            return "common-errorRed"
        case .custom(let name, _):
            return name
        }
    }
    
    private var bundle: Bundle? {
        switch self {
        case .custom(_, let bundle):
            return bundle
        default:
            return nil
        }
    }
    
    /// get dynamic color depends on the light/dark mode
    /// f type is .custom, color will load from provided bundle only. Otherwise, will try to load from main bundle at first, if it is NOT existing, will loan from .commonBundle
    /// - Parameters:
    ///   - opacity: opacity from 0.0-1.0
    ///
    /// - Returns: color
    public func dynamicColor(
        _ opacity: Double = 1
    ) -> Color {
        var color: Color
        if let bundle = bundle {
            color = Color(name, bundle: bundle)
        } else if let uicolor = UIColor(named: name, in: .main, compatibleWith: nil) {
            color = Color(uicolor)
        } else {
            color = Color(name, bundle: .commonBundle)
        }
        
        return color.opacity(opacity)
    }
    
    /// get dynamic color depends on the light/dark mode
    /// f type is .custom, color will load from provided bundle only. Otherwise, will try to load from main bundle at first, if it is NOT existing, will loan from .commonBundle
    /// - Parameters:
    ///   - opacity: opacity from 0.0-1.0
    ///
    /// - Returns: color
    public func uiColor(
        _ opacity: Double = 1
    ) -> UIColor {
        UIColor(dynamicColor(opacity))
    }

}

public extension UIColor {
    
    static func from(
        color: Colors,
        opacity: Double = 1
    ) -> UIColor {
        color.uiColor(opacity)
    }
    
}
