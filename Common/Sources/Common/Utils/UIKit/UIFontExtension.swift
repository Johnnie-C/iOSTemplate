//
//  UIFontExtension.swift
//  
//
//  Created by Johnnie Cheng on 31/10/22.
//

import UIKit

public extension UIFont {
    
    static func registerFont(
        forFontFileExt fileExtensions: [String] = ["otf", "ttf"]
    ) {
        fileExtensions
            .compactMap { Bundle.main.urls(forResourcesWithExtension: $0, subdirectory: nil) }
            .flatMap { $0 }
            .compactMap { CGDataProvider(url: $0 as CFURL) }
            .compactMap { CGFont($0) }
            .forEach { CTFontManagerRegisterGraphicsFont($0, nil) }
    }
    
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
        let descriptor = self.fontDescriptor.withSymbolicTraits(
            UIFontDescriptor.SymbolicTraits(traits)
        )
        
        return UIFont(descriptor: descriptor!, size: size)
    }
    
    func withoutTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let newTraits = self.fontDescriptor.symbolicTraits.subtracting(
            UIFontDescriptor.SymbolicTraits(traits)
        )
        
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(newTraits) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
    
}
