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
