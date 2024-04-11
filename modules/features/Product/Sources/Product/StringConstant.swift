// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Common

extension String {
    
    static func discountPercentage(
        percentage: Double,
        locale: Locale = .NZ
    ) -> String {
        let percentageString = percentage.decimalValue.percentString()
        
        return "ProductListItem.DiscountPercentage"
            .localizedWithFormat(percentageString)
    }
    
}

extension String {
    
    var localized: String {
        localizedString(withKey: self, bundle: .productBundle)
    }
    
    func localizedWithFormat(_ arguments: CVarArg...) -> String {
        localizedString(withKey: self, bundle: .productBundle, arguments)
    }
    
}
