//
//  String+Common.swift
//
//  Created by Johnnie Cheng on 29/4/21.
//

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

public extension String {
    
    var localized: String {
        localizedString(withKey: self)
    }
    
    func localizedWithFormat(_ arguments: CVarArg...) -> String {
        localizedString(withKey: self, arguments)
    }
    
}

public extension StringProtocol {
    
    func index<S: StringProtocol>(
        of string: S,
        options: String.CompareOptions = []
    ) -> Int? {
        range(of: string, options: options)?
            .lowerBound
            .utf16Offset(in: self)
    }
    
}
