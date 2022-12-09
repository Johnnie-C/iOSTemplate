// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import Common

class AppFontProvider: FontProvider {
    
    lazy var black = UIFont(name: "StagSans-Black", size: 1)!
    lazy var blackItalic = UIFont(name: "StagSans-BlackItalic", size: 1)!
    lazy var bold = UIFont(name: "StagSans-Bold", size: 1)!
    lazy var boldItalic = UIFont(name: "StagSans-BoldItalic", size: 1)!
    lazy var semibold = UIFont(name: "StagSans-Semibold", size: 1)!
    lazy var semiboldItalic = UIFont(name: "StagSans-SemiboldItalic", size: 1)!
    lazy var medium = UIFont(name: "StagSans-Medium", size: 1)!
    lazy var mediumItalic = UIFont(name: "StagSans-MediumItalic", size: 1)!
    lazy var book = UIFont(name: "StagSans-Book", size: 1)!
    lazy var bookItalic = UIFont(name: "StagSans-BookItalic", size: 1)!
    lazy var light = UIFont(name: "StagSans-Light", size: 1)!
    lazy var lightItalic = UIFont(name: "StagSans-LightItalic", size: 1)!
    lazy var thin = UIFont(name: "StagSans-Thin", size: 1)!
    lazy var thinItalic = UIFont(name: "StagSans-ThinItalic", size: 1)!
    
    init() {
        UIFont.registerCustomFonts()
    }
    
    func font(forStyle style: FontStyle) -> UIFont {
        let italic = style.italic
        switch style.weight {
        case .ultraLight, .thin:
            return italic ? thinItalic : thin
        case .light:
            return italic ? lightItalic : light
        case .regular:
            return italic ? bookItalic : book
        case .medium:
            return italic ? mediumItalic : medium
        case .semibold:
            return italic ? semiboldItalic : semibold
        case .bold, .heavy:
            return italic ? boldItalic : bold
        case .black:
            return italic ? blackItalic : black
        default:
            return italic ? bookItalic : book
        }
    }
    
}
