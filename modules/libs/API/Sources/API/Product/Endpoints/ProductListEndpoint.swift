// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Networker

class ProductListEndpoint: Endpoint<ProductListDTO> {
    
    init() {
        super.init(
            path: "product",
            decoder: .dateFormattedDecoder(.fullWithSSS)
        )
    }
    
}
