//
//  UIColorExtension.swift
//
//  Created by Johnnie Cheng on 29/4/21.
//

import UIKit

public extension UIColor {

    static var primaryColor: UIColor {
        let defaultColor = #colorLiteral(red: 0.9529411765, green: 0.7450980392, blue: 0.2784313725, alpha: 1)
        if #available(iOS 11.0, *) {
            return UIColor(named: "AccentColor") ?? defaultColor
        } else {
            return defaultColor
        }
    }

    static var secondaryColor: UIColor { .black }
    
    static var titleColor: UIColor {
        let defaultColor = #colorLiteral(red: 0.3058823529, green: 0.3058823529, blue: 0.3058823529, alpha: 1)
        if #available(iOS 11.0, *) {
            return UIColor(named: "titleColor") ?? defaultColor
        } else {
            return defaultColor
        }
    }

    static var subtitleColor: UIColor {
        let defaultColor = #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        if #available(iOS 11.0, *) {
            return UIColor(named: "subtitleColor") ?? defaultColor
        } else {
            return defaultColor
        }
    }

    static var contentColor: UIColor {
        let defaultColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if #available(iOS 11.0, *) {
            return UIColor(named: "contentColor") ?? defaultColor
        } else {
            return defaultColor
        }
    }
    
    static var navigationBarBackgroundColor: UIColor { .primaryColor }
    static var navigationBarTintColor: UIColor { .secondaryColor }

    static var tabBarTintColor: UIColor {
        let defaultColor = UIColor.white
        if #available(iOS 11.0, *) {
            return UIColor(named: "tabBarTintColor") ?? defaultColor
        } else {
            return defaultColor
        }
    }
    
}

extension UIColor {

    var hexString: String {
        let components = cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))

        return hexString
     }

    static func color(fromHex hexString: String) -> UIColor {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

        
        let alpha: CGFloat = 1.0
        let red: CGFloat = colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = colorComponentFrom(colorString: colorString, start: 4, length: 2)

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    private static func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {
        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt64 = 0

        guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)

        return floatValue
    }

}
