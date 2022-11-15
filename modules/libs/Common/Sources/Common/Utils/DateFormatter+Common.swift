//
//  DateFormatter+Common.swift
//
//  Created by Johnnie Cheng on 29/4/21.
//

import Foundation

public enum DateFormat: String {
    case full = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
    case fullWithSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case MMMyyyySpaced = "MMM yyyy"
    case yyyyMMddDashed = "yyyy-MM-dd"
}

public extension DateFormatter {

    /// full date formatter e.g.  "2021-02-02T20:11:16+13:00"
    static var full: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.full.rawValue

        return formatter
    }
    
    /// full date formatter e.g.  "2021-02-02T20:11:16.123Z"
    static var fullWithSSS: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.fullWithSSS.rawValue

        return formatter
    }

    static var MMMyyyySpaced: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.MMMyyyySpaced.rawValue

        return formatter
    }

    static var yyyyMMddDashed: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.yyyyMMddDashed.rawValue

        return formatter
    }
    
    static func customised(format: String) -> DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = format

        return formatter
    }
    
    static var NZDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = .NZ
        formatter.locale = .NZ
        
        return formatter
    }

}
