// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

struct LegacyBottomSheetView<Content: View, Sheet: View>: View {
    
    @State var measuredHeight: CGFloat = 0
    @Binding var isPresented: Bool
    
    let content: () -> Content
    let sheet: () -> Sheet
    let onDismiss: (() -> Void)?
    let allowDismiss: Bool
    
    public init(
        isPresented: Binding<Bool>,
        allowDismiss: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder sheet: @escaping () -> Sheet
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.allowDismiss = allowDismiss
        self.content = content
        self.sheet = sheet
    }
    
    var body: some View {
        content()
            .fullScreenCover(
                isPresented: $isPresented,
                onDismiss: onDismiss
            ) {
                ZStack {
                    Color.clear
                        .contentShape(Rectangle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            if allowDismiss {
                                isPresented = false
                            }
                        }
                    
                    sheetContent
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .background(FullScreenCoverBackgroundRemovalView())
    }
    
    private var sheetContent: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                sheet()
                    .padding(.bottom, geo.safeAreaInsets.bottom)
                    .roundedCorner(12, corners: [.topLeft, .topRight])
            }
        }
        
    }
    
}

private struct FullScreenCoverBackgroundRemovalView: UIViewRepresentable {
    
    private class BackgroundRemovalView : UIView {
        
        override func didMoveToWindow() {
            super.didMoveToWindow()
            superview?.superview?.backgroundColor = .clear
            superview?.superview?.superview?.backgroundColor = .clear.withAlphaComponent(0.15)
        }
        
    }
    
    func makeUIView(context: Context) -> UIView {
        BackgroundRemovalView()
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
    
}
