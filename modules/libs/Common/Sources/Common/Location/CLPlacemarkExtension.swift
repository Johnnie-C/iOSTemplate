// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import CoreLocation

extension CLPlacemark {
    
    var streetNumber: String {
        subThoroughfare ?? ""
    }
    
    var streetName: String {
        thoroughfare ?? ""
    }
    
    var suburb: String {
        subLocality ?? ""
    }
    
    var city: String {
        locality ?? ""
    }
    
    var state: String {
        administrativeArea ?? ""
    }
    
    var address: String? {
        "\(streetNumber) \(streetName), \(suburb), \(state) \(postalCode ?? ""), \(country ?? "")"
    }

}
