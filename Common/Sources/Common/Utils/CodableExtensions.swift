//
//  CodableExtensions.swift
//  MegaBudget
//
//  Created by Johnnie Cheng on 29/4/21.
//

import Foundation

public extension Decodable {
    
    static func decoded(dict: [AnyHashable: Any]?) throws -> Self? {
        guard let dict = dict else { return nil }
        
        let data = try JSONSerialization.data(withJSONObject: dict, options: [])
        return try decoded(data: data)
    }
    
    static func decoded(data: Data?) throws -> Self? {
        guard let data = data else { return nil }
        
        let decodedData = try JSONDecoder().decode(Self.self, from: data)
        return decodedData
    }
    
}

public extension KeyedDecodingContainer {

    /// convenience function where can be used without passing decode type
    /// Due to a precision issue in JSONSerialization, If the decode type Decimal, it will be decoded in the following step:
    /// Data --> Double --> String --> Decimal
    ///
    /// - Parameters:
    ///   - key: decode keu
    ///   - type: decode type. Optional, will use inferred type if not provided
    /// - Throws: decode error
    /// - Returns: decoded object
    func decode<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T {
        if type == Decimal.self {
            return try decode(Double.self, forKey: key).decimalValue as! T
        }
        else {
            return try self.decode(T.self, forKey: key)
        }
    }

    /// convenience function where can be used without passing decode type
    /// Due to a precision issue in JSONSerialization, If the decode type Decimal, it will be decoded in the following step:
    /// Data --> Double --> String --> Decimal
    ///
    /// - Parameters:
    ///   - key: decode keu
    ///   - type: decode type. Optional, will use inferred type if not provided
    /// - Throws: decode error
    /// - Returns: decoded object
    func decodeIfPresent<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T? {
        if type == Decimal.self {
            return try decodeIfPresent(Double.self, forKey: key)?.decimalValue as? T
        }
        else {
            return try decodeIfPresent(T.self, forKey: key)
        }
    }

    func decodeDateIfPresent(_ key: Key, formatter: DateFormatter) throws -> Date? {
        var date: Date? = nil

        if let dateStr: String = try decodeIfPresent(key) {
            date = formatter.date(from: dateStr)
        }

        return date
    }

}
