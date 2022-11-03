//
//  UIFontExtension.swift
//  
//
//  Created by Johnnie Cheng on 20/10/22.
//

import UIKit
import SwiftUI

public class Fonts {
    
    private var fonts: [UIFont.Weight: UIFont] = [
        .ultraLight: UIFont.systemFont(ofSize: 1, weight: .ultraLight),
        .thin: UIFont.systemFont(ofSize: 1, weight: .thin),
        .light: UIFont.systemFont(ofSize: 1, weight: .light),
        .regular: UIFont.systemFont(ofSize: 1, weight: .regular),
        .medium: UIFont.systemFont(ofSize: 1, weight: .medium),
        .semibold: UIFont.systemFont(ofSize: 1, weight: .semibold),
        .bold: UIFont.systemFont(ofSize: 1, weight: .bold),
        .heavy: UIFont.systemFont(ofSize: 1, weight: .heavy),
        .black: UIFont.systemFont(ofSize: 1, weight: .black)
    ]
    
    private var italicFonts: [UIFont.Weight: UIFont] = [
        .ultraLight: UIFont.systemFont(ofSize: 1, weight: .ultraLight),
        .thin: UIFont.systemFont(ofSize: 1, weight: .thin),
        .light: UIFont.systemFont(ofSize: 1, weight: .light),
        .regular: UIFont.systemFont(ofSize: 1, weight: .regular),
        .medium: UIFont.systemFont(ofSize: 1, weight: .medium),
        .semibold: UIFont.systemFont(ofSize: 1, weight: .semibold),
        .bold: UIFont.systemFont(ofSize: 1, weight: .bold),
        .heavy: UIFont.systemFont(ofSize: 1, weight: .heavy),
        .black: UIFont.systemFont(ofSize: 1, weight: .black)
    ]
    
    
    /// all weights must to set for fonts consistency through the app.
    ///
    /// Same font can be used for different weight.
    /// e.g. if the app only use light but doesn't use .ultraLight and .thin, can config like:
    ///
    /// configFontsWithWeight(
    ///     ultraLight: fontForLight,
    ///     thin: fontForLight,
    ///     light: fontForLight,
    ///     regular: fontForRegular,
    ///     ...
    /// )
    func configFontsWithWeight(
        ultraLight: UIFont,
        thin: UIFont,
        light: UIFont,
        regular: UIFont,
        medium: UIFont,
        semibold: UIFont,
        bold: UIFont,
        heavy: UIFont,
        black: UIFont
    ) {
        fonts[.ultraLight] = ultraLight
        fonts[.thin] = thin
        fonts[.light] = light
        fonts[.regular] = regular
        fonts[.medium] = medium
        fonts[.semibold] = semibold
        fonts[.bold] = bold
        fonts[.heavy] = heavy
        fonts[.black] = black
    }
    
//    func configFontsWithWeight(
//        ultraLight: UIFont,
//        thin: UIFont,
//        light: UIFont,
//        regular: UIFont,
//        medium: UIFont,
//        semibold: UIFont,
//        bold: UIFont,
//        heavy: UIFont,
//        black: UIFont
//    ) {
//
//    }
    
}

public extension UIFont {
    
//    func font(forStyle style: FontStyle) -> UIFont {
//        if let font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
//    }
    
//    func dynamicFont(style: FontStyle) -> UIFont {
//        switch style {
//        case .title(let weight):
//            return UIFontMetrics(forTextStyle:.largeTitle)
//                .scaledFont(for: bnzFont (style: .title(fontWeight: fontweight)),
//                            maximumPointSize: style.size.maximum)
//        case
//            .title1(let isBold):
//            return UIFontMetrics(forTextStyle:
//                                    .title1)
//            .scaledFont (for: bnzFont (style: .title1(isBold: isBold)),
//                            maximumPointSize:
//                                style.size.maximum)
//        case .title2(let isBold):
//            I
//            return UIFontMetrics (forTextStyle: .title2)
//            .scaledFont (for: bnzFont (style: .title2(isBold: isBold)),
//                            maximumPointSize: style.size.maximum)
//        case
//            .title3(let isBold):
//            return UIFontMetrics (forTextStyle: .title3)
//            .scaledFont (for: bnzFont (style: .title3(isBold: isBold)),
//                            maximumPointSize: style.size.maximum)
//        case
//        .headline:
//            return UIFontMetrics(forTextStyle:
//                                    .headline)
//            .scaledFont (for: bnzFont (style: .headline),
//                            maximumPointSize: style.size.maximum)
//        }
//    }
    
}

public enum FontStyle {
    
    case title(fontWeight: UIFont.Weight)
    case title1(isBold: Bool)
    case title2(isBold: Bool)
    case title3 (isBold: Bool)
    case headline
    case body
    case callout(isBold: Bool)
    case subhead(fontWeight: UIFont.Weight)
    case footnote(isBold: Bool)
    case caption1
    case caption2
    
    var systemStyle: UIFont.TextStyle{
        switch self {
        case .title: return .largeTitle
        case .title1: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .body: return .body
        case .callout: return .callout
        case .subhead: return .subheadline
        case .footnote: return .footnote
        case .caption1: return .caption1
        case .caption2: return .caption2
        }
    }
    
    var size: FontSize {
        switch self {
        case .title: return .xxxLarge
        case .title1: return .xxLarge
        case .title2: return .xLarge
        case .title3: return .large
        case .headline: return .medium
        case .body: return .medium
        case .callout: return .medium
        case .subhead: return .small
        case .footnote: return .xSmall
        case .caption1: return .small
        case .caption2: return .small
        }
    }
    
}

//extension FontStyle {
//
//    public var dynamicFont: Font {
//        let fontSize = self.size
//        let sizeScaled = min(
//            UIFontMetrics(forTextStyle: self.systemStyle)
//                .scaledValue(for: fontSize.rawValue),
//            fontSize.maximum
//        )
//
//        // TODO: font name
//        return Font.custom(self.weight.rawValue, size: sizeScaled)
//    }
//
//    public var staticfont: Font {
//        // TODO: font name
//        Font.custom(self.weight.rawValue, fixedSize: self.size.rawValue)
//    }
//
//}

public enum FontSize: CGFloat {
    
    case xxxLarge = 32
    case xxLarge = 28
    case xLarge = 24
    case large = 20
    case medium = 17
    case small = 14
    case xSmall = 12
    case xxSmall = 11
    
    var maximum: CGFloat {
        switch self {
        case .xxxLarge: return 38
        case .xxLarge: return 32
        case .xLarge: return 26
        case .large: return 24
        case .medium: return 21
        case .small: return 21
        case .xSmall: return 20
        case .xxSmall: return 19
        }
    }
    
}

public enum BNZFontWeight: String, CaseIterable {
    case italic = "SerranoPro-RegularItalic"
    case regular = "SerranoPro-Regular"
    case semibold = "SerranoPro-Semibold"
    case boldItalic = "SerranoPro-BoldItalic"
    case bold = "SerranoPro-Bold"
}
