// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

@available(iOS 16.0, *)
struct NavigationStackChildView: View {
    
    let item: Int
    @Binding var navigationPath: NavigationPath
    @State var showNewView = false
    
    var body: some View {
        VStack {
            Text("I am \(item)")
            
            Button {
                showNewView = true
            } label: {
                Text("push a new view")
            }
            .padding()
            
            Button {
                navigationPath.removeLast(navigationPath.count)
            } label: {
                Text("Back to Home")
            }
            .padding()
            
            Button {
                navigationPath.removeLast(navigationPath.count)
                navigationPath.append(100)
            } label: {
                Text("Back to Home and append new view")
            }
            .padding()
        }
        .fillParent()
        .navigationTitle("\(item)")
        .navigate(
            to: NavigationStackChildView(
                item: item + 1,
                navigationPath: $navigationPath
            ),
            when: $showNewView
        )
    }

}
