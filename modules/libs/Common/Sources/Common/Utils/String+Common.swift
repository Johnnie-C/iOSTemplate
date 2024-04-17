// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public func localizedString(
    withKey key: String,
    tableName: String? = nil,
    bundle: Bundle = Bundle.main,
    comment: String = "",
    _ arguments: [CVarArg] = []
) -> String {
    var str = NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: comment)

    if !arguments.isEmpty {
        str = String(format: str, locale: .current, arguments: arguments)
    }

    return str
}

///
/// An extension for loading localized string from main bundle
/// If you want to use it in module without passing bundle every time, copy following code into your module
///
/// extension String { // do NOT make this public
///
///     var localized: String {
///         localizedString(withKey: self, bundle: .moduleBundle)
///     }
///
///     func localizedWithFormat(_ arguments: CVarArg...) -> String {
///         localizedString(withKey: self, bundle: .moduleBundle, arguments)
///     }
///
/// }
///
/// public extension Bundle {
///
///     static var moduleBundle: Bundle {
///         Bundle.module
///     }
///
/// }
public extension String {
    
    var localized: String {
        localizedString(withKey: self)
    }
    
    func localizedWithFormat(_ arguments: CVarArg...) -> String {
        localizedString(withKey: self, arguments)
    }
    
}

public extension String {
    
    func index<S: StringProtocol>(
        of string: S,
        options: String.CompareOptions = []
    ) -> Int? {
        range(of: string, options: options)?
            .lowerBound
            .utf16Offset(in: self)
    }
    
    func ranges(of substring: String) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []
        var searchStartIndex = startIndex
        
        while let range = range(of: substring, range: searchStartIndex ..< endIndex) {
            ranges.append(range)
            // Move the search start index beyond the current found range
            searchStartIndex = range.upperBound
        }
        
        return ranges
    }
    
    func nsRanges(
        forText text: String,
        at indexes: [Int]
    ) -> [NSRange] {
        let ranges = ranges(of: text)
        let nsRanges = ranges
            .filter {
                let index = ranges.firstIndex(of: $0)!
                return indexes.contains(index)
            }
            .compactMap {
                $0.nsRange(in: self)
            }
        
        return nsRanges
    }
    
}
