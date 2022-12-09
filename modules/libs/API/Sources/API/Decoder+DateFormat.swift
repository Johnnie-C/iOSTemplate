// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Common

extension JSONDecoder {
    
    static func dateFormattedDecoder(_ dateFormatter: DateFormatter = .full) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }

}
