// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import API

public protocol ProductsProvider {
    
    func productList() async throws -> ProductList
    
}

public class DefaultProductsProvider: ProductsProvider {
    
    private let productListAPI: ProductAPI
    
    public init(productListAPI: ProductAPI = DefaultProductAPI()) {
        self.productListAPI = productListAPI
    }
    
    public func productList() async throws -> ProductList {
        let dto = try await productListAPI.productList()
        return .from(dto: dto)
    }

}
