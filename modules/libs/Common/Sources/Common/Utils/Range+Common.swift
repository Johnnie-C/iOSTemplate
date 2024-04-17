// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation

public extension Range<String.Index> {
    
    func nsRange(in string: String) -> NSRange? {
        if let lowerBound = lowerBound.samePosition(in: string),
            let upperBound = upperBound.samePosition(in: string) {
            
            let location = string.distance(
                from: string.startIndex,
                to: lowerBound
            )
            
            let length = string.distance(
                from: lowerBound,
                to: upperBound
            )
            
            return NSRange(location: location, length: length)
        }
        
        return nil
    }
    
}
