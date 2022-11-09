//
//  AppFontProvider.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 9/11/22.
//

import UIKit
import Common

class AppFontProvider: FontProvider {
    
    let black = UIFont(name: "StagSans-Black", size: 1)!
    let blackItalic = UIFont(name: "StagSans-BlackItalic", size: 1)!
    let bold = UIFont(name: "StagSans-Bold", size: 1)!
    let boldItalic = UIFont(name: "StagSans-BoldItalic", size: 1)!
    let semibold = UIFont(name: "StagSans-Semibold", size: 1)!
    let semiboldItalic = UIFont(name: "StagSans-SemiboldItalic", size: 1)!
    let medium = UIFont(name: "StagSans-Medium", size: 1)!
    let mediumItalic = UIFont(name: "StagSans-MediumItalic", size: 1)!
    let book = UIFont(name: "StagSans-Book", size: 1)!
    let bookItalic = UIFont(name: "StagSans-BookItalic", size: 1)!
    let light = UIFont(name: "StagSans-Light", size: 1)!
    let lightItalic = UIFont(name: "StagSans-LightItalic", size: 1)!
    let thin = UIFont(name: "StagSans-Thin", size: 1)!
    let thinItalic = UIFont(name: "StagSans-ThinItalic", size: 1)!
    
    func font(forStyle style: FontStyle) -> UIFont {
        switch style.weight {
        case .ultraLight, .thin:
            return style.italic ? thinItalic : thin
        case .light:
            return style.italic ? lightItalic : light
        case .regular:
            return style.italic ? bookItalic : book
        case .medium:
            return style.italic ? mediumItalic : medium
        case .semibold:
            return style.italic ? semiboldItalic : semibold
        case .bold, .heavy:
            return style.italic ? boldItalic : bold
        case .black:
            return style.italic ? blackItalic : black
        default:
            return style.italic ? bookItalic : book
        }
    }
    
}
