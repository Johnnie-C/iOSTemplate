//
//  UIFontExtension.swift
//  
//
//  Created by Johnnie Cheng on 20/10/22.
//

import UIKit
import SwiftUI

public extension UIFont {

    func font(forStyle style: FontStyle) -> UIFont { style.staticUIFont }
    func dynamicFont(style: FontStyle) -> UIFont { style.dynamicUIFont }

}

public extension Font {

    func font(forStyle style: FontStyle) -> Font { style.staticFont }
    func dynamicFont(style: FontStyle) -> Font { style.dynamicFont }

}

public enum FontStyle {
    
    fileprivate static var fonts: [FontStyle: UIFont] = [
        .largeTitle: UIFont.preferredFont(forTextStyle: .largeTitle),
        .title1: UIFont.preferredFont(forTextStyle: .title1),
        .title2: UIFont.preferredFont(forTextStyle: .title2),
        .title3: UIFont.preferredFont(forTextStyle: .title3),
        .headline: UIFont.preferredFont(forTextStyle: .headline),
        .subheadline: UIFont.preferredFont(forTextStyle: .subheadline),
        .body: UIFont.preferredFont(forTextStyle: .body),
        .callout: UIFont.preferredFont(forTextStyle: .callout),
        .footnote: UIFont.preferredFont(forTextStyle: .footnote),
        .caption1: UIFont.preferredFont(forTextStyle: .caption1),
        .caption2: UIFont.preferredFont(forTextStyle: .caption2)
    ]
    
    fileprivate static var customMaxSizeEnabled = true
    
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case footnote
    case caption1
    case caption2
    
    var systemStyle: UIFont.TextStyle{
        switch self {
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
        }
    }
    
    var size: CGFloat {
        switch self {
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
        }
    }
    
    var maxSize: CGFloat {
        switch self {
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
        }
    }
    
    var font: UIFont { FontStyle.fonts[self] ?? UIFont.preferredFont(forTextStyle: .body) }
    
}

public extension FontStyle {
    
    static func configFonts(
        largeTitle: UIFont,
        title1: UIFont,
        title2: UIFont,
        title3: UIFont,
        headline: UIFont,
        subheadline: UIFont,
        body: UIFont,
        callout: UIFont,
        footnote: UIFont,
        caption1: UIFont,
        caption2: UIFont
    ) {
        fonts[.largeTitle] = largeTitle
        fonts[.title1] = title1
        fonts[.title2] = title2
        fonts[.title3] = title3
        fonts[.headline] = headline
        fonts[.subheadline] = subheadline
        fonts[.body] = body
        fonts[.callout] = callout
        fonts[.footnote] = footnote
        fonts[.caption1] = caption1
        fonts[.caption2] = caption2
    }
    
    func enableMaxCustomSize(enabled: Bool) {
        FontStyle.customMaxSizeEnabled = enabled
    }
    
}

extension FontStyle {

    public var dynamicUIFont: UIFont {
        let systemSize = UIFontMetrics(forTextStyle: systemStyle).scaledValue(for: size)
        let sizeScaled = min(
            systemSize,
            maxSize
        )
        
        return font.withSize(FontStyle.customMaxSizeEnabled ? sizeScaled : systemSize)
    }

    public var staticUIFont: UIFont {font.withSize(size) }
    
    public var dynamicFont: Font {
        Font(dynamicUIFont)
    }
    
    public var staticFont: Font { Font(staticUIFont) }

}
