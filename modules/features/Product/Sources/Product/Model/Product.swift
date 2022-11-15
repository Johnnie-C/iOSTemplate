//
//  Product.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Foundation
import API

public struct Product {
    
    let id: String
    let createdAt: Date
    let name: String
    let avatar: String?
    
}

extension Product {
    
    static func from(dto: ProductDTO) -> Product {
        .init(
            id: dto.id,
            createdAt: dto.createdAt,
            name: dto.name,
            avatar: dto.avatar
        )
    }
    
}
