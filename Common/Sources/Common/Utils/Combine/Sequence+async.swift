//
//  Sequence+async.swift
//  
//
//  Created by Johnnie Cheng on 27/10/22.
//

import Combine

public extension Sequence {
    
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }

}
