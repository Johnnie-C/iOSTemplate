// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Product
import WidgetDemo

struct AppTabView: View {
    
    var body: some View {
        TabView {
            FeatureDemoListView()
                .tabItem {
                    Label("Feature Demo", systemImage: "list.star")
                }
            WidgetDemoListView()
                .tabItem {
                    Label("Widget Demo", systemImage: "paintbrush.pointed.fill")
                }
        }
    }

}
