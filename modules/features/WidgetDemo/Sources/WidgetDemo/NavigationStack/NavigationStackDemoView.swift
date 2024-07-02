// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

@available(iOS 16.0, *)
struct NavigationStackDemoView: View {
    
    private let items = [1, 2, 3, 4, 5, 6, 7]
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(items, id: \.self) { item in
                NavigationLink("\(item)", value: item)
            }
            .navigationTitle("NavigationStack Demo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Int.self) { item in
                NavigationStackChildView(item: item, navigationPath: $navigationPath)
            }
        }
    }
    
}
