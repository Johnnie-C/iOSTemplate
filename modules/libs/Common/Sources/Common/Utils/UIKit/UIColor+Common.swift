// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

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

extension UIColor {
    
    static let systemTintColor: UIColor = UIView().tintColor
    
}
