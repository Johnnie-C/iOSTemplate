//
//  UIFontExtension.swift
//  
//
//  Created by Johnnie Cheng on 31/10/22.
//

import UIKit

extension UIFont {
    
    static func italicSystemFont(
        size: CGFloat,
        weight: UIFont.Weight = .regular
    )-> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        switch weight {
        case .ultraLight, .light, .thin, .regular:
            return font.withTraits(.traitItalic, ofSize: size)
        case .medium, .semibold, .bold, .heavy, .black:
            return font.withTraits(.traitBold, .traitItalic, ofSize: size)
        default:
            return UIFont.italicSystemFont(ofSize: size)
        }
    }
    
    func withTraits(
        _ traits: UIFontDescriptor.SymbolicTraits...,
        ofSize size: CGFloat
    ) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: size)
    }
    
}
