// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import SDWebImageSwiftUI
import Common

struct ViewTransitionListView: View {
    
    @State var selectedItem: ViewTransitionItem?
    @State var selectedItemImageFrame: CGRect = .zero
    @State var selectedItemImage: UIImage?
    @State var showDetail: Bool = false
    @State var hideSelectedItemImage: Bool = false
    @State var hideImageOnDetailView: Bool = false
    @State var transitionProvider: ViewTransitionProtocol?
    
    private let items = ViewTransitionListView.createItems()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(items) { item in
                        ItemView(
                            item: item,
                            hideImage: item == selectedItem && hideSelectedItemImage,
                            onTap: { imageFrame, image in
                                selectedItem = item
                                selectedItemImageFrame = imageFrame
                                selectedItemImage = image
                                navigateToDetail()
                            }
                        )
                        .padding(.small)
                    }
                }
                .padding(.top, .medium)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("View Transaction")
        .background(.backgroundColor)
        .navigate(to: detailView, when: $showDetail)
        .transitionAnimation(transitionProvider: $transitionProvider)
    }
    
    @ViewBuilder
    private var detailView: some View {
        Group {
            if let item = selectedItem {
                ViewTransitionDetailView(item: item, hideImage: hideImageOnDetailView)
            } else {
                EmptyView()
            }
        }
    }
    
    func navigateToDetail() {
        let duration = 0.5
        transitionProvider = ImageExpandToTopTransition(
            fromFrame: selectedItemImageFrame, 
            toFrame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 250), 
            duration: duration,
            transitionImage: selectedItemImage,
            onTransitionStart: { operation in
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + duration * 0.9
                ) {
                    switch operation {
                    case .push:
                        hideImageOnDetailView = false
                    case .pop:
                        hideSelectedItemImage = false
                    default:
                        break
                    }
                }
            }
        )
        
        hideSelectedItemImage = true
        hideImageOnDetailView = true
        showDetail = true
    }
    
}

fileprivate extension ViewTransitionListView {
    
    struct ItemView: View {
        
        let item: ViewTransitionItem
        var hideImage: Bool
        let onTap: (_ imageFrame: CGRect, _ image: UIImage?) -> Void
        @State var imageFrame: CGRect = .zero
        @State var image: UIImage = Icons.imagePlaceholder.uiImage()
        
        var body: some View {
            VStack(commonSpacing: .xSmall) {
                if hideImage {
                    Text("")
                        .fillWidth()
                        .frame(height: 250)
                } else {
                    WebImage(url: item.imageUrl)
                        .onSuccess { image, _, _ in
                            self.image = image
                        }
                        .resizable()
                        .placeholder(.imagePlaceholder)
                        .indicator(.activity)
                        .fillWidth()
                        .frame(height: 250)
                        .scaledToFill()
                        .roundedCorner(5)
                        .observeFrame(in: .global) { frame in
                            imageFrame = frame
                        }
                }
                
                Text(item.title)
            }
            .onTapGesture { onTap(imageFrame, image) }
        }
        
    }
    
}

fileprivate extension ViewTransitionListView {
    
    static func createItems() -> [ViewTransitionItem] {
        return [
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
    }
    
}
