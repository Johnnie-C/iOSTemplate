// **********************************************************
//    Copyright © 2025 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

@available(iOS 26.0, *)
struct GlassEffectsDemoView: View {
    
    @Namespace var nameSpace
    
    // track the cumulative vertical offset
    @State private var yOffset: CGFloat = 0
    // track the active drag translation
    @GestureState private var dragTranslation: CGSize = .zero
    
    
    var body: some View {
        ZStack {
            backgroundImage
            
            GlassEffectContainer {
                VStack {
                    Button("Glass Effect Button") { }
                        .buttonStyle(.glass)
                        .glassEffectID(1, in: nameSpace)
                    
                    Text("Glass Effect Text")
                        .padding(.vertical, .xSmall)
                        .padding(.horizontal, .small)
                        .glassEffect(in: .rect(cornerRadius: 8))
                        .glassEffectID(2, in: nameSpace)
                        .offset(y: yOffset + dragTranslation.height)
                        .gesture(
                            DragGesture()
                                .updating($dragTranslation) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    yOffset += value.translation.height
                                }
                        )
                }
                .padding(.medium)
            }
        }
        .fillParent()
        .navigationTitle("Glass Effects Demo")
    }
    
    private var backgroundImage: some View {
        Image(
            uiImage: UIImage(
                named: "glass-background",
                in: Bundle.module,
                with: nil
            )!
        )
        .resizable()
        .aspectRatio(contentMode: .fill)
        .fillParent()
    }
    
}
