//
//  ProductListView.swift
//  
//
//  Created by Johnnie Cheng on 13/11/22.
//

import SwiftUI
import Common

public struct ProductListView<VM: ProductListViewModel>: View {

    @ObservedObject var viewModel: VM
    @State private var showDetail = false
    @State private var selectedProduct: Product?
    
    private let productAssembly: ProductAssembly

    public init(
        viewModel: VM = DefaultProductListViewModel(),
        productAssembly: ProductAssembly = DefaultProductAssembly()
    ) {
        self.viewModel = viewModel
        self.productAssembly = productAssembly
    }

    public var body: some View {
        NavigationView {
            VStack {
                // reference for later guideline demo
//                Text("test body").font(FontStyle.body().dynamicFont)
//                Text("test bold italic").font(FontStyle.body(weight: .bold, italic: true).dynamicFont)
//                Text("test title1 heavy").font(FontStyle.title1(weight: .heavy).dynamicFont)
//                AttributedTextView(
//                    attributedText: "qwe {?:here is the message} qwe".attributed(),
//                    tooltipTappedAction: { message in
//
//                    }
//                )
                ScrollView {
                    VStack(alignment: .leading) {
                        if let products = viewModel.productList?.products {
                            ForEach(products) { product in
                                ProductListItemView(product: product)
                                    .fillWidth()
                                    .paddingVertical(.xSmall)
                                    .onTapGesture {
                                        self.selectedProduct = product
                                        self.showDetail = true
                                    }
                                if product.id != products.last?.id {
                                    CommonDivider()
                                }
                            }
                        }
                    }
                    .fillParent()
                }
                .fillParent()
            }
            .navigationTitle("List")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alertMessage(alertMessage: $viewModel.alertMessage)
            .withLoadingHandler(isLoading: $viewModel.isLoading)
            .onAppear { viewModel.onAppear() }
            .navigate(to: productDetailView, when: $showDetail)
        }
    }
    
    @ViewBuilder
    private var productDetailView: some View {
        Group {
            if let product = selectedProduct {
                productAssembly.assembleProductDetailView(
                    product: product
                )
            } else {
                EmptyView()
            }
        }
    }

}

