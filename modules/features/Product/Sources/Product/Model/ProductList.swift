// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import API

public struct ProductList {
    
    let products: [Product]?
    
}

extension ProductList{
    
    static func from(dto: ProductListDTO) -> ProductList {
        .init(products: dto.products?.map { Product.from(dto: $0) })
    }
    
}
