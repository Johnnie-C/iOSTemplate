//
//  TimeZoneExtension.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Foundation

extension TimeZone {
    
    static var NZ: TimeZone { TimeZone(abbreviation: "NZST") ?? .current }

}
