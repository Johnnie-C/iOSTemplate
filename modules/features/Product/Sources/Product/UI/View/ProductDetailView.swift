//
//  ProductDetailView.swift
//  
//
//  Created by Johnnie Cheng on 17/11/22.
//

import SwiftUI

public struct ProductDetailView<VM: ProductDetailViewModel>: View {
    
    @ObservedObject var viewModel: VM
    private let productAssembly: ProductAssembly

    public init(
        viewModel: VM,
        productAssembly: ProductAssembly = DefaultProductAssembly()
    ) {
        self.viewModel = viewModel
        self.productAssembly = productAssembly
    }

    public var body: some View {
        Text("")
            .navigationTitle("Detail")
    }

}
