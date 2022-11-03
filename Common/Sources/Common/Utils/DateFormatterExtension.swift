//
//  DateFormatterExtension.swift
//
//  Created by Johnnie Cheng on 29/4/21.
//

import Foundation

public extension DateFormatter {

    /// full date formatter e.g.  "2021-02-02T20:11:16+13:00"
    static var full: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"

        return formatter
    }

    static var MMMyyyySpaced: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"

        return formatter
    }

    static var yyyyMMddDashed: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter
    }

}
