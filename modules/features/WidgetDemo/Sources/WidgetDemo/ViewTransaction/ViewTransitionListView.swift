// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import SDWebImageSwiftUI

struct ViewTransitionListView: View {
    
    private let items = [
        ViewTransitionItem(imageUrl: RandomImage().url(id: 0), title: "Test Image: \(0)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 10), title: "Test Image: \(10)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 20), title: "Test Image: \(20)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 30), title: "Test Image: \(30)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 40), title: "Test Image: \(40)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 50), title: "Test Image: \(50)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 60), title: "Test Image: \(60)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 70), title: "Test Image: \(70)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 80), title: "Test Image: \(80)"),
        ViewTransitionItem(imageUrl: RandomImage().url(id: 90), title: "Test Image: \(90)"),
    ]
    
    @Namespace var namespace
    @State var selectedItem: ViewTransitionItem?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(items) { item in
                        ItemView(
                            item: item,
                            namespace: namespace,
                            onTap: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    selectedItem = item
                                }
                            }
                        )
                        .padding(.small)
                    }
                }
                .padding(.top, .medium)
            }
            if selectedItem != nil {
                ViewTransitionDetailView(
                    namespace: namespace,
                    item: $selectedItem
                )
                .fillParent(alignment: .top)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("View Transaction")
        .background(.backgroundColor)
    }
    
    struct ItemView: View {
        let item: ViewTransitionItem
        var namespace: Namespace.ID
        let onTap: () -> Void
        
        var body: some View {
            VStack(commonSpacing: .xSmall) {
                WebImage(url: item.imageUrl)
                    .resizable()
                    .placeholder(.imagePlaceholder)
                    .indicator(.activity)
                    .fillWidth()
                    .frame(height: 250)
                    .scaledToFill()
                    .roundedCorner(5)
                    .matchedGeometryEffect(
                        id: item.imageGeometryEffectId,
                        in: namespace
                    )
                Text(item.title)
                    .matchedGeometryEffect(
                        id: item.titleGeometryEffectId,
                        in: namespace
                    )
            }
            .onTapGesture { onTap() }
        }
    }

}

extension ViewTransitionItem {
    
    var imageGeometryEffectId: String {
        "ViewTransitionItem_image_\(id)"
    }
    
    var titleGeometryEffectId: String {
        "ViewTransitionItem_title_\(id)"
    }
    
}
