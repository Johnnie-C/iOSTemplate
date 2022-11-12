//
//  ProductListAPI.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Foundation
import Networker
import Common

protocol ProductListAPI {
    func productList() async throws -> [ProductDTO]
}

class DefaultProductListAPI: ProductListAPI {
    
    enum EndPoint: String {
        case productList = "product"
    }
    
    private let networker: NetworkerProtocol
    
    init(
        networker: NetworkerProtocol = DIContainer.default.resolve(type: NetworkerProtocol.self)
    ) {
        self.networker = networker
    }
    
    func productList() async throws -> [ProductDTO] {
        try await networker.performRequest(forEndpoint: EndPoint.productList.rawValue)
    }

}
