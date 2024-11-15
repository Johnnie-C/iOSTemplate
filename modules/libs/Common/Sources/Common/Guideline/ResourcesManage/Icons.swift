// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import UIKit

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
///
/// Note: to overwrite an existing image in Common module, create an image in main app's Assets.xcassets with the same name
///
public extension Icons {
    
    static var info: Icons {
        overwritableIcon("common-info")
    }
    
    static var warnings: Icons {
        overwritableIcon("common-warnings")
    }
    
    static var imagePlaceholder: Icons {
        overwritableIcon("common-imagePlaceholder")
    }
    
    
    /// Get icons for given name.
    /// In order to allow main app to overrite the image in common module,
    /// this function will use the overwritten image in main bundle if has.
    ///
    /// - Parameter name: image name
    /// - Returns: icon
    private static func overwritableIcon(_ name: String) -> Icons {
        var bundle = Bundle.main
        if UIImage(named: name, in: bundle, with: nil) == nil {
            bundle = .commonBundle
        }
        
        return .named(name, bundle: bundle)
    }
}

public enum Icons {
    
    case named(_ name: String, bundle: Bundle = .main)
    
    case system(_ name: String)
    
    case custom(_ image: UIImage)
    
    private var name: String {
        switch self {
        case .named(let name, _):
            return name
        case .system(let name):
            return name
        case .custom(_):
            return ""
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
        case .named(let name, let bundle):
            image = UIImage(named: name, in: bundle, with: nil) ?? UIImage()
        }
        
        if let color = color?.uiColor() {
            image = image
                .withRenderingMode(.alwaysTemplate)
                .withTintColor(color)
        }
        
        return image
    }
    
    public func templateUIImage() -> UIImage {
        return uiImage().withRenderingMode(.alwaysTemplate)
    }
    
    public func image() -> Image {
        return Image(icon: self)
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
