//
//  ProductAssembly.swift
//  
//
//  Created by Johnnie Cheng on 16/11/22.
//

import SwiftUI

public protocol ProductAssembly {
    
    func assembleProductListView(productProvider: ProductsProvider) -> AnyView
    func assembleProductDetailView(product: Product) -> AnyView
    
}

public class DefaultProductAssembly: ProductAssembly {
    
    public init() { }
    
    @ViewBuilder
    public func assembleProductListView(
        productProvider: ProductsProvider = DefaultProductsProvider()
    ) -> AnyView {
        let viewModel = DefaultProductListViewModel(
            productProvider: productProvider
        )
        
        AnyView(
            ProductListView(
                viewModel: viewModel,
                productAssembly: self
            )
        )
    }
    
    @ViewBuilder
    public func assembleProductDetailView(product: Product) -> AnyView {
        let viewModel = DefaultProductDetailViewModel(
            product: product
        )
        
        AnyView(
            ProductDetailView(
                viewModel: viewModel,
                productAssembly: self
            )
        )
    }

}
