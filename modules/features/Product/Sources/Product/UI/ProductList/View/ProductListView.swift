// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

public struct ProductListView: View {

    @StateObject var viewModel: ProductListViewModel
    @State private var showDetail = false
    @State private var selectedProduct: Product?
    
    private let productAssembly: ProductAssembly

    public init(
        viewModel: ProductListViewModel = ProductListViewModel(),
        productAssembly: ProductAssembly = DefaultProductAssembly()
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.productAssembly = productAssembly
    }

    public var body: some View {
        VStack {
            if viewModel.error != nil {
                ErrorView(
                    title: .genericErrorTitle,
                    description: .genericErrorMessage,
                    retry: .init(isLoading: $viewModel.isLoading) {
                        viewModel.reload()
                    }
                )
            } else {
                contentView
                    .withLoadingHandler(isLoading: $viewModel.isLoading)
            }

            
            
            
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

//                ImageButton("test", fontStyle: .body(), icon: .info, color: .errorRed) {
//                    print("tapped")
//                }
        }
        .navigationTitle(
            title: "List",
            hideBackButtonTitleOnNextView: true
        )
        .fillParent()
        .alertMessage(alertMessage: $viewModel.alertMessage)
        .onAppear { viewModel.onAppear() }
        .navigate(to: productDetailView, when: $showDetail)
//            .rightItem(item: .init(title: "title", icon: nil) {
//                print("item tapped")
//            })
//        .rightItems(
//            items: [
//                .init(title: "title", icon: nil) {
//                    print("item tapped")
//                },
//                .init(title: "Done", icon: .system("square.and.pencil"), style: .done) {
//                    print("done tapped")
//                }
//            ]
//        )
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
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

