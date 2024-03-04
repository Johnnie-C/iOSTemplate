// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import CoreLocation

public extension CLLocation {
    
    var placemark: CLPlacemark? {
        get async {
            try? await CLGeocoder()
                .reverseGeocodeLocation(self)
                .first
        }
    }
    
    var address: String? {
        get async {
            let placemark = await placemark
            return placemark?.address ?? ""
        }
    }
    
}
