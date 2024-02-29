// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import SDWebImageSwiftUI
import Common

struct ViewTransitionDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showLandingAnimationStep1 = false
    @State var showLandingAnimationStep2 = false
    
    let item: ViewTransitionItem
    let hideImage: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(commonSpacing: .xSmall) {
                    if hideImage {
                        Text("")
                            .fillWidth()
                            .frame(height: 250)
                    } else {
                        WebImage(url: item.imageUrl)
                            .resizable()
                            .placeholder(.imagePlaceholder)
                            .indicator(.activity)
                            .fillWidth()
                            .frame(height: 250)
                            .scaledToFill()
                            .roundedCorner(5, corners: [.topLeft, .topRight])
                    }
                    
                    Text(item.title)
                        .padding(.horizontal, .small)
                        .padding(.top, .medium)
                        .offset(y: showLandingAnimationStep1 ? 0 : 200)
                        .opacity(showLandingAnimationStep1 ? 1 : 0)
                        .animation(
                            .lightSpringAnimation(),
                            value: showLandingAnimationStep1
                        )
                    
                    descriptionText
                        .padding(.small)
                        .offset(y: showLandingAnimationStep2 ? 0 : 200)
                        .opacity(showLandingAnimationStep2 ? 1 : 0)
                        .animation(
                            .lightSpringAnimation(),
                            value: showLandingAnimationStep2
                        )
                }
                .padding(.bottom, CommonSize.standardHeight.rawValue + 40)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        showLandingAnimationStep1 = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showLandingAnimationStep2 = true
                    }
                }
            }
            
            VStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
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
            .fillParent()
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
    }
    
    private var descriptionText: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id tellus dolor. Mauris auctor justo nibh, at pharetra magna ullamcorper a. Nam metus ex, ultricies a gravida sed, vestibulum nec felis. Suspendisse potenti. Ut finibus eros ut sem pellentesque venenatis. Ut tincidunt augue eu venenatis laoreet. Sed auctor erat quis mattis dapibus. Cras non tristique nunc. Mauris purus elit, interdum id orci quis, egestas sodales nulla. In velit quam, aliquet non leo sed, aliquam luctus nulla. Integer et convallis leo, eu mollis urna.\n\nIn risus risus, scelerisque ut pretium eget, porttitor semper turpis. Nulla commodo elit vitae malesuada accumsan. Donec ornare justo viverra laoreet tincidunt. Etiam eget condimentum massa, eu ultricies purus. Aenean rhoncus semper purus, non vehicula ex blandit vel. Fusce tempus elementum velit non elementum. Ut aliquam massa quis pulvinar pellentesque. Mauris mollis purus ut dictum sagittis.")
    }
    
}
