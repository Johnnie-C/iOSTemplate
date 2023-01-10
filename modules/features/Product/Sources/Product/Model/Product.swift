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
    private let thumbnail: String?
    private let images: [String]?
    
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
    
    var thumbnailURL: ImageURL? {
        guard let thumbnail = thumbnail else { return nil }
        
        return ImageURL(url: URL(string: thumbnail))
    }
    
    public var imageUrls: [ImageURL]? {
        guard let images = images else { return nil }
        
        return images.compactMap { ImageURL(url: URL(string: $0)) }
    }
    
}

public struct ImageURL: Identifiable {
    
    public var id = UUID()
    public let url: URL?
    
}
