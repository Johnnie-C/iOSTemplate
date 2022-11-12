//
//  Decoder+DateFormat.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Foundation
import Common

extension JSONDecoder {
    
    static func dateFormattedDecoder(_ dateFormatter: DateFormatter = .full) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }

}
