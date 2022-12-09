// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

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
