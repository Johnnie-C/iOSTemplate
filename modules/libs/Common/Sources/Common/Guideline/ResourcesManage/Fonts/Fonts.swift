// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import SwiftUI

public extension UIFont {

    static func font(_ style: FontStyle) -> UIFont { style.staticUIFont }
    static func dynamicFont(_ style: FontStyle) -> UIFont { style.dynamicUIFont }

}

public extension Font {

    static func font(_ style: FontStyle) -> Font { style.staticFont }
    static func dynamicFont(_ style: FontStyle) -> Font { style.dynamicFont }

}

public enum FontStyle {
    
    fileprivate static var limitedMaxSizeEnabled = true
    fileprivate static var fontProvider: FontProvider = DefaultFontProvider()
    
    // default font style reference:
    // https://developer.apple.com/design/human-interface-guidelines/foundations/typography/#specifications
    //
    // https://gist.github.com/zacwest/916d31da5d03405809c4
    
    /// available iOS17, will fallback to `largeTitle` if below iOS17
    case extraLargeTitle(weight: UIFont.Weight = .bold, italic:  Bool = false)
    
    /// available iOS17, will fallback to `largeTitle` if below iOS17
    case extraLargeTitle2(weight: UIFont.Weight = .bold, italic:  Bool = false)

    case largeTitle(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case title1(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case title2(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case title3(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case headline(weight: UIFont.Weight = .semibold, italic:  Bool = false)
    case subheadline(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case body(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case callout(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case footnote(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case caption1(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case caption2(weight: UIFont.Weight = .regular, italic:  Bool = false)
    case custom(_ font: UIFont)
    
    var systemStyle: UIFont.TextStyle {
        switch self {
        case .extraLargeTitle:
            if #available(iOS 17.0, *) {
                return .extraLargeTitle
            } else {
                return .largeTitle
            }
        case .extraLargeTitle2:
            if #available(iOS 17.0, *) {
                return .extraLargeTitle2
            } else {
                return .largeTitle
            }
        case .largeTitle: return .largeTitle
        case .title1: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption1: return .caption1
        case .caption2: return .caption2
        case .custom: return .body
        }
    }
    
    var size: CGFloat {
        switch self {
        case .extraLargeTitle: return 36
        case .extraLargeTitle2: return 28
        case .largeTitle: return 34
        case .title1: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .subheadline: return 15
        case .body: return 17
        case .callout: return 17
        case .footnote: return 13
        case .caption1: return 12
        case .caption2: return 11
        case .custom(let font): return font.pointSize
        }
    }
    
    var maxSize: CGFloat {
        switch self {
        case .extraLargeTitle: return 40
        case .extraLargeTitle2: return 32
        case .largeTitle: return 38
        case .title1: return 32
        case .title2: return 26
        case .title3: return 24
        case .headline: return 21
        case .subheadline: return 19
        case .body: return 21
        case .callout: return 21
        case .footnote: return 20
        case .caption1: return 16
        case .caption2: return 15
        case .custom(let font): return font.pointSize
        }
    }
    
    public var weight: UIFont.Weight {
        switch self {
        case .extraLargeTitle(let weight, _): 
            return weight
        case .extraLargeTitle2(let weight, _):
            return weight
        case .largeTitle(let weight, _):
            return weight
        case .title1(let weight, _):
            return weight
        case .title2(let weight, _):
            return weight
        case .title3(let weight, _):
            return weight
        case .headline(let weight, _):
            return weight
        case .subheadline(let weight, _):
            return weight
        case .body(let weight, _):
            return weight
        case .callout(let weight, _):
            return weight
        case .footnote(let weight, _):
            return weight
        case .caption1(let weight, _):
            return weight
        case .caption2(let weight, _):
            return weight
        case .custom(let font): return font.weight
        }
    }
    
    public var italic: Bool {
        switch self {
        case .extraLargeTitle(_, let italic):
            return italic
        case .extraLargeTitle2(_, let italic):
            return italic
        case .largeTitle(_, let italic):
            return italic
        case .title1(_, let italic):
            return italic
        case .title2(_, let italic):
            return italic
        case .title3(_, let italic):
            return italic
        case .headline(_, let italic):
            return italic
        case .subheadline(_, let italic):
            return italic
        case .body(_, let italic):
            return italic
        case .callout(_, let italic):
            return italic
        case .footnote(_, let italic):
            return italic
        case .caption1(_, let italic):
            return italic
        case .caption2(_, let italic):
            return italic
        case .custom(let font): return font.isItalic
        }
    }
    
    fileprivate var font: UIFont { FontStyle.fontProvider.font(forStyle: self) }
    
}

public extension FontStyle {
    
    static func setFontProvider(_ provider: FontProvider) {
        FontStyle.fontProvider = provider
    }
    
    static func limitMaxSize(enabled: Bool) {
        FontStyle.limitedMaxSizeEnabled = enabled
    }
    
}

extension FontStyle {

    public var dynamicUIFont: UIFont {
        if case .custom(let font) = self {
            return font
        }
        
        let systemSize = UIFontMetrics(forTextStyle: systemStyle).scaledValue(for: size)
        let sizeScaled = min(
            systemSize,
            maxSize
        )
        
        return font.withSize(FontStyle.limitedMaxSizeEnabled ? sizeScaled : systemSize)
    }

    public var staticUIFont: UIFont { font.withSize(size) }
    
    public var dynamicFont: Font { Font(dynamicUIFont) }
    public var staticFont: Font { Font(staticUIFont) }

}
