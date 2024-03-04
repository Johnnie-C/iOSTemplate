// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Product
import FeatureDemo

struct FeatureDemoListView: View {
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    NavigationLink(destination: DefaultProductAssembly().assembleProductListView()) {
                        Text("Product list/detail")
                    }
                    NavigationLink(destination: LocationDemoView()) {
                        Text("Location manager")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Email validator")
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
