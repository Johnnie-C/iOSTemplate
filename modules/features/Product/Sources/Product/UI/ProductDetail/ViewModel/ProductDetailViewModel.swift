//
//  ProductDetailViewModel.swift
//  
//
//  Created by Johnnie Cheng on 17/11/22.
//

import Foundation
import Common

public protocol ProductDetailViewModel: ObservableObject {
    
    var product: Product { get }

}

public class DefaultProductDetailViewModel: ProductDetailViewModel {
    
    public let product: Product
    
    public init(product: Product) {
        self.product = product
    }

}
