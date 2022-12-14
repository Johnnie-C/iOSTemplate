// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************


import SwiftUI
import Common

public struct WidgetDemoListView: View {
    
    public init() { }
    
    public var body: some View {
        NavigationView {
            List {
                Group {
                    NavigationLink(destination: Text("TODO")) {
                        Text("Custom fonts")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Attributed Text view / Tooltip")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Image button")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Bottom sheet")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Navigation bar buttons")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Toast / alert")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Frame observer")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("Email validator")
                    }
                }
                .standardHeight()
            }
            .listStyle(PlainListStyle())
            .background(.backgroundColor)
            .navigationBarTitle("Widget Demo")
            .fillParent()
        }
    }
    
}
