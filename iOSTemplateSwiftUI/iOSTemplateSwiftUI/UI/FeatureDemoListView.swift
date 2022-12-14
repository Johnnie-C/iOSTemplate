// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Product

struct FeatureDemoListView: View {
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    NavigationLink(destination: DefaultProductAssembly().assembleProductListView()) {
                        Text("Product list/detail")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Location manager")
                    }
                }
                .standardHeight()
            }
            .listStyle(PlainListStyle())
            .background(.backgroundColor)
            .navigationBarTitle("Feature Demo")
            .fillParent()
        }
    }
    
}
