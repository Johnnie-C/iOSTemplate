//
//  Publisher+onEach.swift
//  
//
//  Created by Johnnie Cheng on 27/10/22.
//

import Combine

public extension Publisher {
    
    func onEach(
        _ transform: @escaping (Self.Output) -> Void
    ) -> Publishers.Map<Self, Self.Output> {
        map { output -> Self.Output in
            transform(output)
            return output
        }
    }

}
