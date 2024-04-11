// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import UIKit

public enum Icons {
    
    case info
    case warnings
    case imagePlaceholder
    
    /// an example for using custom icon in module
    ///
    /// define icons for convenience use
    ///
    ///     extension Icons {
    ///         static var myIconInModule: Icons {
    ///             .named(name: "icon name", bundle: .myModuleBundle)
    ///         }
    ///     }
    ///
    /// use icon
    ///
    ///     Image(icon: .myIconInModule)
    ///
    case named(name: String, bundle: Bundle = .main)
    
    case system(_ name: String)
    
    case custom(_ image: UIImage)
    
    private var name: String {
        switch self {
        case .info:
            return "icon-info"
        case .warnings:
            return "warnings"
        case .imagePlaceholder:
            return "imagePlaceholder"
        case .named(let name, _):
            return name
        case .system(let name):
            return name
        case .custom(_):
            return ""
        }
    }
    
    private var bundle: Bundle {
        switch self {
        case .named(_, let bundle):
            return bundle
        default:
            return .commonBundle
        }
    }
    
    
    /// Get UIImage with color to tint.
    ///
    /// For `Image` used in SwiftUI, use `Image(icon: Icons)`
    /// to tint: `Image(icon: .icon).foregroundColor(.color)`
    ///
    /// - Parameter color: color to tint
    /// - Returns: return tinted uiimage
    public func uiImage(_ color: Colors? = nil) -> UIImage {
        var image: UIImage
        
        switch self {
        case .system(let name):
            image = UIImage.init(systemName: name) ?? UIImage()
        case .custom(let customImage):
            image = customImage
        default:
            image = UIImage(named: name, in: bundle, with: nil) ?? UIImage()
        }
        
        if let color = color?.uiColor() {
            image = image.withTintColor(color)
        }
        
        return image
    }
    
    public func templateImage() -> UIImage {
        var image = UIImage(named: name, in: bundle, with: nil) ?? UIImage()
        image = image.withRenderingMode(.alwaysTemplate)
        
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
