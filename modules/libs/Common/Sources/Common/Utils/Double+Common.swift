// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation

public extension Double {

    var decimalValue: Decimal {
        return Decimal(string: "\(self)") ?? Decimal(self)
    }

}
