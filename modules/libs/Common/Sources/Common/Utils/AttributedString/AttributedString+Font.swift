// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public extension NSAttributedString {

    /// Apply give font to entire string
    /// - Parameter fontStyle: fontStyle
    /// - Returns: modified AttributedString
    func font(_ fontStyle: FontStyle) -> NSAttributedString {
        return font(fontStyle.dynamicUIFont)
    }
    
    /// Apply give font to entire string
    /// - Parameter font: UIFont
    /// - Returns: modified AttributedString
    func font(_ font: UIFont) -> NSAttributedString {
        let attributedStr = mutable()
        
        attributedStr.addAttributes(
            [.font: font],
            range: NSRange(location: 0, length: attributedStr.length)
        )
        
        return attributedStr
    }
    
    /// Apply given font to substrings that appears at given indexes
    /// e.g.
    ///     ```
    ///     let str = "abc abc".attributed()
    ///     str.font(.title1(), text: "abc", indexes: [1])
    ///     ```
    /// only 2nd "abc" will be have the font
    ///
    /// - Parameters:
    ///   - fontStyle: fontStyle
    ///   - text: substring to add font
    ///   - indexes: indexes for substring to apply font
    /// - Returns: modified AttributedString
    func font(
        _ fontStyle: FontStyle,
        text: String,
        indexes: [Int] = [0]
    ) -> NSAttributedString {
        return font(
            fontStyle.dynamicUIFont,
            text: text,
            indexes: indexes
        )
    }
    
    /// Apply given font to substrings that appears at given indexes
    /// e.g.
    ///     ```
    ///     let str = "abc abc".attributed()
    ///     str.font(someUIFont, text: "abc", indexes: [1])
    ///     ```
    /// only 2nd "abc" will be have the font
    ///
    /// - Parameters:
    ///   - font: UIFont
    ///   - text: substring to add font
    ///   - indexes: indexes for substring to apply font
    /// - Returns: modified AttributedString
    func font(
        _ font: UIFont,
        text: String,
        indexes: [Int] = [0]
    ) -> NSAttributedString {
        let mutableString = mutable()
        
        mutableString.string
            .nsRanges(forText: text, at: indexes)
            .forEach {
                mutableString.addAttributes(
                    [.font: font],
                    range: $0
                )
            }
        
        return mutableString
    }
    
}
