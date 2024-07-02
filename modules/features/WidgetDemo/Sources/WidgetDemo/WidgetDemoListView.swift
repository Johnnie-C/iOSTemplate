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
                    NavigationLink(destination: CustomFontsDemoView()) {
                        Text("Custom fonts")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Colors Demo")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("TODO Icons Demo")
                    }
                    NavigationLink(destination: TooltipsDemoView()) {
                        Text("Attributed Text view / Tooltip")
                    }
                    NavigationLink(destination: ImageButtonDemoView()) {
                        Text("Image Button")
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
                    NavigationLink(destination: SortableListDemoView()) {
                        Text("Sortable List")
                    }
                    
                    if #available(iOS 16.0, *) {
                        NavigationLink(destination: ViewTransitionListView()) {
                            Text("View Transition")
                        }
                    }
                }
                .standardHeight()
                
                if #available(iOS 16.0, *) {
                    NavigationStackDemoItem
                }
            }
            .listStyle(PlainListStyle())
            .background(.backgroundColor)
            .navigationBarTitle("Widget Demo")
            .fillParent()
        }
    }
    
    @available(iOS 16.0, *)
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
