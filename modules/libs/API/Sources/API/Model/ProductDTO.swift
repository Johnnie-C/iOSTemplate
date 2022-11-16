//
//  ProductDTO.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Foundation

public struct ProductDTO: Decodable {
    
    public let id: String
    public let createdAt: Date
    public let name: String
    public let avatar: String?

}
