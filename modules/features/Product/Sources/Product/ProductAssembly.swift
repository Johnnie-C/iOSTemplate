//
//  ProductAssembly.swift
//  
//
//  Created by Johnnie Cheng on 16/11/22.
//

import SwiftUI

public protocol ProductAssembly {
    
}

public class DefaultProductAssembly: ProductAssembly {
    
    public init() { }
    
    @ViewBuilder
    public func assembleProductListView() -> some View {
        let viewModel = DefaultProductListViewModel(
            productAssembly: self
        )
        
        ProductListView(viewModel: viewModel)
    }

}
