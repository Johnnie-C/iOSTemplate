// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

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
