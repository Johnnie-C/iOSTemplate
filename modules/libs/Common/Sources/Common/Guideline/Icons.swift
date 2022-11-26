//
//  Icons.swift
//  
//
//  Created by Johnnie Cheng on 24/10/22.
//

import SwiftUI
import UIKit

public enum Icons {
    
    case info
    case imagePlaceholder
    
    /// an example for using custom icon in module
    ///
    /// define icons for convenience use
    ///
    ///     extension Icons {
    ///         static var myIconInModule: Icons {
    ///             .custom(name: "icon name", bundle: .myModuleBundle)
    ///         }
    ///     }
    ///
    /// use icon
    ///
    ///     Image(icon: .myIconInModule)
    ///
    case custom(name: String, bundle: Bundle = .main)
    
    private var name: String {
        switch self {
        case .info:
            return "icon-info"
        case .imagePlaceholder:
            return "imagePlaceholder"
        case .custom(let name, _):
            return name
        }
    }
    
    private var bundle: Bundle {
        switch self {
        case .custom(_, let bundle):
            return bundle
        default:
            return .commonBundle
        }
    }
    
    public func image(_ color: Colors? = nil) -> UIImage {
        var image = UIImage(named: name, in: bundle, with: nil) ?? UIImage()
        if let color = color?.uiColor() {
            image = image.withRenderingMode(.alwaysTemplate)
                .withTintColor(color)
        }
        else {
            image = image.withRenderingMode(.alwaysOriginal)
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
        icon.image(color)
    }
    
}
