// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import SDWebImageSwiftUI

struct ViewTransitionDetailView: View {
    
    var namespace: Namespace.ID
    @Binding var item: ViewTransitionItem?
    
    var body: some View {
        if let item {
            ZStack {
                VStack(commonSpacing: .xSmall) {
                    WebImage(url: item.imageUrl)
                        .resizable()
                        .placeholder(.imagePlaceholder)
                        .indicator(.activity)
                        .frame(width: 400)
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
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id tellus dolor. Mauris auctor justo nibh, at pharetra magna ullamcorper a. Nam metus ex, ultricies a gravida sed, vestibulum nec felis. Suspendisse potenti. Ut finibus eros ut sem pellentesque venenatis. Ut tincidunt augue eu venenatis laoreet. Sed auctor erat quis mattis dapibus. Cras non tristique nunc. Mauris purus elit, interdum id orci quis, egestas sodales nulla. In velit quam, aliquet non leo sed, aliquam luctus nulla. Integer et convallis leo, eu mollis urna.\n\nIn risus risus, scelerisque ut pretium eget, porttitor semper turpis. Nulla commodo elit vitae malesuada accumsan. Donec ornare justo viverra laoreet tincidunt. Etiam eget condimentum massa, eu ultricies purus. Aenean rhoncus semper purus, non vehicula ex blandit vel. Fusce tempus elementum velit non elementum. Ut aliquam massa quis pulvinar pellentesque. Mauris mollis purus ut dictum sagittis.")
                }
                
                Button {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        self.item = nil
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.weight(.bold))
                        .foregroundColor(.secondary)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .frame(size: .standardHeight)
                .padding(20)
            }
            .ignoresSafeArea()
            .background(.red)
        } else {
            EmptyView()
        }
    }

}
