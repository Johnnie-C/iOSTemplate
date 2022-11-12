//
//  ProductsProvider.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import API

public protocol ProductsProvider {
    func productList() async throws -> ProductListDTO
}

public class DefaultProductsProvider: ProductsProvider {
    
    private let productListAPI: ProductListAPI
    
    public init(productListAPI: ProductListAPI = DefaultProductListAPI()) {
        self.productListAPI = productListAPI
    }
    
    public func productList() async throws -> ProductListDTO {
        let products = try await productListAPI.productList()
        return products
    }

}
