//
//  ProductListItemView.swift
//  
//
//  Created by Johnnie Cheng on 16/11/22.
//

import SwiftUI
import Common

struct ProductListItemView: View {
    
    let product: Product
    
    var body: some View {
        HStack(commonSpacing: .medium) {
            Image(icon: .info).setSize(.large)
            VStack(alignment: .leading, commonSpacing: .xSmall) {
                Text(product.name, fontStyle: .title3())
                
                let createdDateStr = product.createdAt.string(withFormatter: .ddMMyyyySpaced)
                Text(
                    "ProductListItem.CreatedAt".localizedWithFormat(createdDateStr),
                    fontStyle: .footnote(italic: true)
                )
            }
            Spacer()
        }
        .paddingHorizontal(.small)
    }

}
