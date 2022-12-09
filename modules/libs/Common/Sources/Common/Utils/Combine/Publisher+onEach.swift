// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

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
