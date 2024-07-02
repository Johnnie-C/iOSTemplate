// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    @ViewBuilder
    func bottomSheet<Sheet: View>(
        isPresented: Binding<Bool>,
        estimatedHeight: BottomSheetEstimatedHeight = .small,
        allowDismiss: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder sheet: @escaping () -> Sheet
    ) -> some View {
        BottomSheet(
            isPresented: isPresented,
            estimatedHeight: estimatedHeight,
            allowDismiss: allowDismiss,
            onDismiss: onDismiss,
            content: { self },
            sheet: sheet
        )
    }
    
}

public struct BottomSheet<Content: View, Sheet: View>: View {
    
    @Binding var isPresented: Bool
    
    private let estimatedHeight: BottomSheetEstimatedHeight
    private let content: () -> Content
    private let sheet: () -> Sheet
    private let onDismiss: (() -> Void)?
    private let allowDismiss: Bool
    
    public init(
        isPresented: Binding<Bool>,
        estimatedHeight: BottomSheetEstimatedHeight = .small,
        allowDismiss: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder sheet: @escaping () -> Sheet
    ) {
        self._isPresented = isPresented
        self.estimatedHeight = estimatedHeight
        self.onDismiss = onDismiss
        self.allowDismiss = allowDismiss
        self.content = content
        self.sheet = sheet
    }
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            BottomSheetView(
                isPresented: $isPresented,
                estimatedHeight: estimatedHeight,
                allowDismiss: allowDismiss,
                onDismiss: onDismiss,
                content: content,
                sheet: sheet
            )
        } else {
            LegacyBottomSheetView(
                isPresented: $isPresented,
                allowDismiss: allowDismiss,
                onDismiss: onDismiss,
                content: content,
                sheet: sheet
            )
        }
    }
    
}

public enum BottomSheetEstimatedHeight {
    case xSmall
    case small
    case medium
    case large
    
    var height: CGFloat {
        switch self {
        case .xSmall:
            UIScreen.main.bounds.size.height * 0.1
        case .small:
            UIScreen.main.bounds.size.height * 0.2
        case .medium:
            UIScreen.main.bounds.size.height * 0.5
        case .large:
            UIScreen.main.bounds.size.height * 0.8
        }
    }
}
