//
//  DoubleExtension.swift
//  MegaBudget
//
//  Created by Johnnie Cheng on 29/4/21.
//

import Foundation

public extension Double {

    var decimalValue: Decimal {
        return Decimal(string: "\(self)") ?? Decimal(self)
    }

}
