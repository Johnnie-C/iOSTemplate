//
//  StringExtension.swift
//
//  Created by Johnnie Cheng on 29/4/21.
//

import Foundation

public func localizedString(withKey key: String,
                            bundle: Bundle = Bundle.main,
                            comment: String = "",
                            _ arguments: CVarArg...)
    -> String
{
    var str = NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: comment)
    
    if !arguments.isEmpty {
        str = String(format: str, locale: .current, arguments: arguments)
    }
    
    return str
}
