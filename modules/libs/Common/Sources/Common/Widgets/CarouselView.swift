// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public struct CarouselView<Content: View, Item: Identifiable>: View {
    
    @Binding var index: Int
    @State private var offset: CGFloat = 0
    @State private var isGestureActive: Bool = false
    @State private var items: [Item]
    @State private var translationX: CGFloat = 0
    private let content: (Item) -> Content
    private let showPageIndicator: Bool
    
    public init(
        items: [Item],
        index: Binding<Int>,
        showPageIndicator: Bool = true,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self._index = index
        self.showPageIndicator = showPageIndicator
        self.content = content
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, commonSpacing: .zero) {
                        ForEach(items) { item in
                            content(item).frame(width: geometry.size.width)
                        }
                    }
                }
                .content.offset(
                    x: isGestureActive
                        ? offset
                        : -geometry.size.width * CGFloat(index)
                )
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isGestureActive = true
                            let diffX = value.translation.width - translationX
                            translationX = value.translation.width
                            
                            // calculate bounce friction
                            let isScrollLeft = translationX > 0
                            let hasPreItem = index > 0
                            let hasNextItem = index < items.count - 1
                            var friction = 0.0
                            if !hasPreItem && isScrollLeft
                                || !hasNextItem && !isScrollLeft {
                                friction = abs(translationX) / (geometry.size.width)
                            }
                            
                            offset += diffX * (1 - friction)
                        }
                        .onEnded { value in
                            translationX = 0
                            if -value.predictedEndTranslation.width > geometry.size.width / 2,
                                index < items.endIndex - 1 {
                                index += 1
                            }
                            if value.predictedEndTranslation.width > geometry.size.width / 2,
                               index > 0 {
                                index -= 1
                            }
                            withAnimation { offset = -geometry.size.width * CGFloat(index) }
                            DispatchQueue.main.async { isGestureActive = false }
                        }
                )
            }
            
            if showPageIndicator {
                PageIndicator(
                    indicatorColor: Colors.primaryColor.dynamicColor(),
                    currentIndicatorColor: Colors.primaryColor.dynamicColor(0.6),
                    numberOfPages: items.count,
                    currentIndex: index
                )
            }
        }
    }
    
}

public struct PageIndicator: View {
    
    let indicatorColor: Color
    let currentIndicatorColor: Color
    
    let numberOfPages: Int
    let currentIndex: Int
    
    public init(
        indicatorColor: Color = Colors.custom(.white).dynamicColor(),
        currentIndicatorColor: Color = Colors.custom(.white).dynamicColor(0.6),
        numberOfPages: Int,
        currentIndex: Int
    ) {
        self.indicatorColor = indicatorColor
        self.currentIndicatorColor = currentIndicatorColor
        self.numberOfPages = numberOfPages
        self.currentIndex = currentIndex
    }
    
    public var body: some View {
        VStack {
            if numberOfPages <= 1 {
                EmptyView()
            } else {
                HStack(commonSpacing: .xSmall) {
                    ForEach(0..<numberOfPages, id: \.self) { index in
                        Circle()
                            .fill(
                                currentIndex == index ? indicatorColor : currentIndicatorColor
                            )
                            .scaleEffect(currentIndex == index ? 1 : 0.75)
                            .frame(size: .xSmall)
                            .transition(AnyTransition.opacity.combined(with: .scale))
                            .id(index)
                    }
                }
            }
        }
    }
    
}
