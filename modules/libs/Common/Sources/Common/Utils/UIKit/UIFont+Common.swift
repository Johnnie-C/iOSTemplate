// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public extension UIFont {
    
    static func registerCustomFonts(
        fromBundle bundle: Bundle = .main,
        forFontFileExt fileExtensions: [String] = ["otf", "ttf"]
    ) {
        fileExtensions
            .compactMap { bundle.urls(forResourcesWithExtension: $0, subdirectory: nil) }
            .flatMap { $0 }
            .forEach { registerFont(url: $0) }
    }
    
    static func registerFont(url: URL) {
        guard
            let provider = CGDataProvider(url: url as CFURL),
            let font = CGFont(provider)
        else {
            return
        }
        
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
    
    var isItalic: Bool {
        fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    func italic(_ isItalic: Bool = true) -> UIFont {
        if isItalic {
            return withTraits(.traitItalic, ofSize: pointSize)
        } else {
            return withoutTraits(.traitItalic)
        }
    }
    
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else { return .regular }
        
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }
    
    func weight(_ weight: UIFont.Weight) -> UIFont {
        let newDescriptor = fontDescriptor.addingAttributes(
            [ .traits: [UIFontDescriptor.TraitKey.weight: weight] ]
        )
        return UIFont(descriptor: newDescriptor, size: pointSize)
    }
    
    var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any] ?? [:]
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
