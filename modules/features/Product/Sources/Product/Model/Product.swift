// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import API

public struct Product: Identifiable {
    
    public let id: String
    public let title: String
    public let description: String
    public let price: Double
    public let discountPercentage: Double?
    public let rating: Double
    public let stock: Int
    public let brand: String
    public let category: String
    public let thumbnail: String?
    public let images: [String]?
    
}

extension Product {
    
    static func from(dto: ProductDTO) -> Product {
        .init(
            id: "\(dto.id)",
            title: dto.title,
            description: dto.description,
            price: dto.price,
            discountPercentage: dto.discountPercentage,
            rating: dto.rating,
            stock: dto.stock,
            brand: dto.brand,
            category: dto.category,
            thumbnail: dto.thumbnail,
            images: dto.images
        )
    }
    
    var thumbnailURL: URL? {
        guard let thumbnail = thumbnail else { return nil }
        
        return URL(string: thumbnail)
    }
    
}
