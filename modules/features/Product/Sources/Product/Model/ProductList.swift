//
//  ProductList.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

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
