// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import SwiftUI

public extension NSAttributedString {

    /// Apply give color to entire string
    /// - Parameter color: color
    /// - Returns: modified AttributedString
    func color(_ color: Colors) -> NSAttributedString {
        self.color(color.dynamicColor())
    }
    
    /// Apply give color to entire string
    /// - Parameter color: color
    /// - Returns: modified AttributedString
    func color(_ color: Color) -> NSAttributedString {
        self.color(UIColor(color))
    }
    
    /// Apply give color to entire string
    /// - Parameter color: color
    /// - Returns: modified AttributedString
    func color(_ color: UIColor) -> NSAttributedString {
        let attributedStr = mutable()
        
        attributedStr.addAttributes(
            [.foregroundColor: color],
            range: NSRange(location: 0, length: attributedStr.length)
        )
        
        return attributedStr
    }
    
    /// Apply given color to substrings that appears at given indexes
    /// e.g.
    ///     ```
    ///     let str = "abc abc".attributed()
    ///     str.color(.warningYellow, text: "abc", indexes: [1])
    ///     ```
    /// only 2nd "abc" will be yellow
    ///
    /// - Parameters:
    ///   - color: color
    ///   - text: substring to add color
    ///   - indexes: indexes for substring to apply color
    /// - Returns: modified AttributedString
    func color(
        _ color: Colors,
        text: String,
        indexes: [Int] = [0]
    ) -> NSAttributedString {
        self.color(
            color.dynamicColor(),
            text: text,
            indexes: indexes
        )
    }
    
    /// Apply given color to substrings that appears at given indexes
    /// e.g.
    ///     ```
    ///     let str = "abc abc".attributed()
    ///     str.color(.yellow, text: "abc", indexes: [1])
    ///     ```
    /// only 2nd "abc" will be yellow
    ///
    /// - Parameters:
    ///   - color: color
    ///   - text: substring to add color
    ///   - indexes: indexes for substring to apply color
    /// - Returns: modified AttributedString
    func color(
        _ color: Color,
        text: String,
        indexes: [Int] = [0]
    ) -> NSAttributedString {
        self.color(
            UIColor(color),
            text: text,
            indexes: indexes
        )
    }
    
    /// Apply given color to substrings that appears at given indexes
    /// e.g.
    ///     ```
    ///     let str = "abc abc".attributed()
    ///     str.color(.yellow, text: "abc", indexes: [1])
    ///     ```
    /// only 2nd "abc" will be yellow
    ///
    /// - Parameters:
    ///   - color: uicolor
    ///   - text: substring to add color
    ///   - indexes: indexes for substring to apply color
    /// - Returns: modified AttributedString
    func color(
        _ color: UIColor,
        text: String,
        indexes: [Int] = [0]
    ) -> NSAttributedString {
        let mutableString = mutable()
        
        mutableString.string
            .nsRanges(forText: text, at: indexes)
            .forEach {
                mutableString.addAttributes(
                    [.foregroundColor: color],
                    range: $0
                )
            }
        
        return mutableString
    }
    
}
