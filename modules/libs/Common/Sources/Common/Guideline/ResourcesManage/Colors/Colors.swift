// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import UIKit

/// Pre-defined semantic colors. If need to override, create "Colors" assets in main app with same color names
public enum Colors {
    
    case primaryColor
    case secondaryColor
    
    case titleColor
    case subtitleColor
    case primaryLabel
    case disabledTextColor
    
    case backgroundColor
    case shadow
    case divider
    
    case infoBlue
    case errorRed
    case successGreen
    
    /// an example for using custom color in module
    ///
    /// define colors for convenience use
    ///
    ///     extension Colors {
    ///         static var myColorInModule: Colors {
    ///             .named(name: "myColor", bundle: .myModuleBundle)
    ///         }
    ///     }
    ///
    /// use color
    ///
    ///     "text".styled(font: .body(), color: .myColorInModule)
    ///
    case named(name: String, bundle: Bundle = .main)
    
    case custom(_ color: UIColor)
    
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
        case .disabledTextColor:
            return "common-disabledTextColor"
        case .successGreen:
            return "common-successGreen"
        case .named(let name, _):
            return name
        case .custom(_):
            return ""
        }
    }
    
    private var bundle: Bundle? {
        switch self {
        case .named(_, let bundle):
            return bundle
        default:
            return nil
        }
    }
    
    /// get dynamic color depends on the light/dark mode
    /// if type is .named, color will load from provided bundle only. Otherwise, will try to load from main bundle at first, if it is NOT existing, will loan from .commonBundle
    /// - Parameters:
    ///   - opacity: opacity from 0.0-1.0
    ///
    /// - Returns: color
    public func dynamicColor(
        _ opacity: Double = 1
    ) -> Color {
        var color: Color
        switch self {
        case .named(let name, let bundle):
            color = Color(name, bundle: bundle)
        case .custom(let customColor):
            color = Color(customColor)
        default:
            if let uicolor = UIColor(named: name, in: .main, compatibleWith: nil) {
                color = Color(uicolor)
            } else {
                color = Color(name, bundle: .commonBundle)
            }
        }
        
        return color.opacity(opacity)
    }
    
    /// get dynamic color depends on the light/dark mode
    /// f type is .named, c321olor will load from provided bundle only. Otherwise, will try to load from main bundle at first, if it is NOT existing, will loan from .commonBundle
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
