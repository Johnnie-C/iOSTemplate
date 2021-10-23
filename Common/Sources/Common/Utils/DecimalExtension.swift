//
//  DecimalExtension.swift
//  MegaBudget
//
//  Created by Johnnie Cheng on 29/4/21.
//

import Foundation

public extension Decimal {

    func currencyString(for locale: Locale = .NZ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter.string(for: self) ?? "$\(self)"
    }

    var currencyValue: Decimal {
        let decimals = Set("0123456789.")
        let decimalOnlyStr = String(currencyString().filter{decimals.contains($0)})
        return Decimal(string: decimalOnlyStr) ?? self
    }

}
