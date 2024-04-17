// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public extension NSAttributedString {

    /// Apply given url as link to entire string
    /// - Parameter url: url
    /// - Returns: modified AttributedString
    func link(_ url: String) -> NSAttributedString {
        guard self.length > 0 else { return self }
    
        let mutableString = self.mutable()
        mutableString.addAttribute(
            .link,
            value: url,
            range: NSRange(
                location: 0,
                length: mutableString.length
            )
        )
        
        return mutableString
    }
    
    /// Apply given url as link to substrings that appears at given indexes
    /// e.g.
    ///     ```
    ///     let str = "abc abc".attributed()
    ///     str.link(text: "abc", url: someURL, indexes: [1])
    ///     ```
    /// only 2nd "abc" will be added a link
    ///
    /// - Parameters:
    ///   - text: substring to add link
    ///   - url: url
    ///   - indexes: indexes for substring to apply link
    /// - Returns: modified AttributedString
    func link(
        text: String,
        withUrl url: String,
        indexes: [Int] = [0]
    ) -> NSAttributedString {
        guard
            self.length > 0,
            text.count > 0,
            !indexes.isEmpty
        else {
            return self
        }
    
        let mutableString = self.mutable()
        
        mutableString.string
            .nsRanges(forText: text, at: indexes)
            .forEach {
                mutableString.addAttribute(
                    .link,
                    value: url,
                    range: $0
                )
            }
        
        return mutableString
    }
    
}
