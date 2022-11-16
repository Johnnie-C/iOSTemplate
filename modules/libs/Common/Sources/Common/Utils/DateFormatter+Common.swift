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
    case ddMMMyyyySpaced = "dd MMM yyyy"
    case yyyyMMddDashed = "yyyy-MM-dd"
    case ddMMyyyyDashed = "dd-MM-yyyy"
    case ddMMyyyySlashed = "dd/MM/yyyy"
    case ddMMyyyySpaced = "dd MM yyyy"
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

    // e.g. "Feb 2021"
    static var MMMyyyySpaced: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.MMMyyyySpaced.rawValue

        return formatter
    }
    
    // e.g. "21 Feb 2021"
    static var ddMMMyyyySpaced: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.ddMMMyyyySpaced.rawValue

        return formatter
    }

    // e.g. "2021-02-21"
    static var yyyyMMddDashed: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.yyyyMMddDashed.rawValue

        return formatter
    }
    
    // e.g. "21 02 2021"
    static var ddMMyyyySpaced: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.ddMMyyyySpaced.rawValue

        return formatter
    }
    
    // e.g. "21-02-2021"
    static var ddMMyyyyDashed: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.ddMMyyyyDashed.rawValue

        return formatter
    }
    
    // e.g. "21/02/2021"
    static var ddMMyyyySlashed: DateFormatter {
        let formatter = DateFormatter.NZDateFormatter
        formatter.dateFormat = DateFormat.ddMMyyyySlashed.rawValue

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
