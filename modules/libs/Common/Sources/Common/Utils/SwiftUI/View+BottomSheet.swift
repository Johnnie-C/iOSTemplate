// **********************************************************
//    Copyright © 2026 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    @ViewBuilder
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        allowDismiss: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        modifier(
            ButtomSheetModifier(
                isPresented: isPresented,
                allowDismiss: allowDismiss,
                content: content
            )
        )
    }
    
}

private struct ButtomSheetModifier<BottomSheetContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    @State private var hasMeasuredSize = false
    @State private var contentHeight: CGFloat = 0
    
    private let allowDismiss: Bool
    private let bottomSheetContent: () -> BottomSheetContent
    
    init(
        isPresented: Binding<Bool>,
        allowDismiss: Bool,
        @ViewBuilder content: @escaping () -> BottomSheetContent
    ) {
        self._isPresented = isPresented
        self.allowDismiss = allowDismiss
        self.bottomSheetContent = content
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            // off-screen measuring content height only once
            // to fix the broken sliding on animation when presented at the first time
            //
            // What causes the issue:
            // the detent height changed from 0 to actual height while presenting
            if !hasMeasuredSize {
                bottomSheetContent()
                    .opacity(0)
                    .measureSize {
                        self.contentHeight = $0.height
                        hasMeasuredSize = true
                    }
            }
        }
        .sheet(isPresented: $isPresented) {
            bottomSheetContent()
                .interactiveDismissDisabled(!allowDismiss)
                .measureSize {
                    self.contentHeight = $0.height
                }
                .presentationDetents([.height(contentHeight)])
        }
    }
    
}
