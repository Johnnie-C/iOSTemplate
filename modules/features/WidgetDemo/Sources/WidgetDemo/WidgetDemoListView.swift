// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

public struct WidgetDemoListView: View {
    
    public init() { }
    @State var showNavigationStackDemo = false
    
    public var body: some View {
        NavigationView {
            List {
                Group {
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Custom fonts")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Attributed Text view / Tooltip")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Image button")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Bottom sheet")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Navigation bar buttons")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Toast / alert")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Frame observer")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Carousel")
                    }
                    NavigationLink(destination: SortableListView()) {
                        Text("Sortable list")
                    }
                    NavigationLink(destination: ViewTransitionListView()) {
                        Text("View Transition")
                    }
                }
                .standardHeight()
                
                NavigationStackDemoItem  
            }
            .listStyle(PlainListStyle())
            .background(.backgroundColor)
            .navigationBarTitle("Widget Demo")
            .fillParent()
        }
    }
    
    private var NavigationStackDemoItem: some View {
        Button {
            showNavigationStackDemo = true
        } label: {
            Text("NavigationStack Demo")
        }
        .standardHeight()
        .sheet(isPresented: $showNavigationStackDemo) {
            NavigationStackDemoView()
        }
    }
    
}
