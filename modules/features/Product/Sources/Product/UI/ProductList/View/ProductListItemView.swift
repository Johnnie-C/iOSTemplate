// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common
import SDWebImageSwiftUI

struct ProductListItemView: View {
    
    let product: Product
    
    var body: some View {
        HStack(commonSpacing: .medium) {
            WebImage(url: product.thumbnailURL?.url)
                .resizable()
                .placeholder(.imagePlaceholder)
                .indicator(.activity)
                .frame(size: .xxxLarge)
                .scaledToFill()
                .roundedCorner(5)
            
            VStack(alignment: .leading, commonSpacing: .xSmall) {
                Text(product.title, fontStyle: .title3())
                HStack(commonSpacing: .xSmall) {
                    Text(
                        product.price.decimalValue.currencyString(),
                        fontStyle: .body()
                    )
                    
                    if let discount = product.discountPercentage {
                        Text(
                            .discountPercentage(percentage: discount),
                            fontStyle: .body(italic: true),
                            color: .errorRed
                        )
                    }
                }
            }
            Spacer()
        }
        .paddingHorizontal(.small)
    }

}
