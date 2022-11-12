//
//  ProductDTO.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Foundation

public struct ProductDTO: Decodable {
    
    let id: String
    let createdAt: Date
    let name: String
    let avatar: String?

}
