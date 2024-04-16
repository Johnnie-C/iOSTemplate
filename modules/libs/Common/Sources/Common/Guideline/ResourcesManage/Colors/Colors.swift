// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import UIKit

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
/// Note: to overwrite an existing color in Common module, create a color in main app's Colors.xcassets with the same name
public extension Colors {
    
    static var primaryColor: Colors {
        overwritableColor("common-primaryColor")
    }
    static var secondaryColor: Colors {
        overwritableColor("common-secondaryColor")
    }
    
    static var titleColor: Colors {
        overwritableColor("common-titleColor")
    }
    static var subtitleColor: Colors {
        overwritableColor("common-subtitleColor")
    }
    static var primaryLabel: Colors {
        overwritableColor("common-primaryLabel")
    }
    static var disabledTextColor: Colors {
        overwritableColor("common-disabledTextColor")
    }
    static var actionTitleColor: Colors {
        overwritableColor("common-actionTitleColor")
    }
    
    static var backgroundColor: Colors {
        overwritableColor("common-backgroundColor")
    }
    static var shadow: Colors {
        overwritableColor("common-shadow")
    }
    static var divider: Colors {
        overwritableColor("common-divider")
    }
    
    static var infoBlue: Colors {
        overwritableColor("common-info-blue")
    }
    static var errorRed: Colors {
        overwritableColor("common-errorRed")
    }
    static var warningYellow: Colors {
        overwritableColor("common-warningYellow")
    }
    static var successGreen: Colors {
        overwritableColor("common-successGreen")
    }
    
    private static func overwritableColor(_ name: String) -> Colors {
        var bundle = Bundle.main
        
        if UIColor(named: name, in: bundle, compatibleWith: nil) == nil {
            bundle = .commonBundle
        }
        
        return .named(name, bundle: bundle)
    }
    
}

public enum Colors {
    
    case named(_ name: String, bundle: Bundle = .main)
    
    case custom(_ color: UIColor)
    
    private var name: String {
        switch self {
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
        }
        
        return color.opacity(opacity)
    }
    
    /// get dynamic color depends on the light/dark mode
    /// if type is .named, color will load from provided bundle only. Otherwise, will try to load from main bundle at first, if it is NOT existing, will loan from .commonBundle
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
