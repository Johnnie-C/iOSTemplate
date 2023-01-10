// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common
import SDWebImageSwiftUI

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
    
    @State var index: Int = 0
    
    public var body: some View {
        ScrollView {
            VStack {
                if let images = viewModel.product.imageUrls {
                    CarouselView(items: images, index: $index) { imageUrl in
                        WebImage(url: imageUrl.url)
                            .resizable()
                            .placeholder(.imagePlaceholder)
                            .indicator(.activity)
                            .scaledToFit()
                    }
                    .frame(height: 250)
                }
                
                VStack(alignment: .leading, commonSpacing: .xSmall) {
                    Text(viewModel.product.title, fontStyle: .title2(weight: .bold))
                    VStack(alignment: .leading, commonSpacing: .xxSmall) {
                        Text(
                            viewModel.product.price.decimalValue.currencyString(),
                            fontStyle: .body()
                        )
                        
                        if let discount = viewModel.product.discountPercentage?.decimalValue.percentString() {
                            Text(
                                "ProductListItem.DiscountPercentage".localizedWithFormat(discount),
                                fontStyle: .subheadline(italic: true),
                                color: .errorRed
                            )
                        }
                    }
                    Text(viewModel.product.description, fontStyle: .body())
                        .commonLineSpacing(.expanded)
                        .padding(.top, .xSmall)
                }
                .fillWidth(alignment: .topLeading)
                .padding(.top, .small)
                .paddingHorizontal(.small)
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .fillParent()
    }

}
