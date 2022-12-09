// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation

extension TimeZone {
    
    static var NZ: TimeZone { TimeZone(abbreviation: "NZST") ?? .current }

}
