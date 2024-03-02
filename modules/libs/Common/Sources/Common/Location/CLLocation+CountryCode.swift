// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import CoreLocation

public extension CLLocation {
    
    var countryCode: String? {
        get async {
            try? await CLGeocoder()
                .reverseGeocodeLocation(self)
                .first?
                .isoCountryCode
        }
    }
    
}
