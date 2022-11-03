//
//  BottomSheetView.swift
//  
//
//  Created by Johnnie Cheng on 22/10/22.
//

import SwiftUI

public struct BottomSheetView<Content: View>: View {
    
    private var content: () -> Content
    
    private let allDismiss: Bool
    private let allGestures: Bool
    private let bottomSheetAnimation = Animation.linear(duration: 0.2)
    
    @Binding public var show: Bool
    
    @State private var shouldShow: Bool = false
    @State private var positiveOffset: CGFloat = 0.0
    @State private var negativeOffset: CGFloat = 0.0
    
    public init(
        show: Binding<Bool>,
        allDismiss: Bool = true,
        allGestures: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self._show = show
        self.allDismiss = allDismiss
        self.allGestures = allGestures
    }
    
    private var minOffset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            background
            if shouldShow {
                bottomSheet
            }
        }
        .onChange(of: show) { show in
            resetBottomSheet(show)
        }
        .onAppear {
            guard show else { return }
            resetBottomSheet(show)
        }
        edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    private var background: some View {
        if shouldShow {
            Color.black.opacity(0.7)
                .onTapGesture {
                    if allDismiss {
                        show = false
                    }
                }
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    @ViewBuilder
    private var bottomSheet: some View {
        VStack(spacing: 0) {
            ZStack {
                Colors.backgroundColor.dynamicColor()
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .shadow(
                        color: Colors.shadow.dynamicColor(),
                        radius: 5, x: 0, y: -2
                    )
                
                content()
                    .frame(maxWidth: .infinity)
            }
            
            Colors.backgroundColor.dynamicColor()
                .frame(height: max(positiveOffset, minOffset))
                .edgesIgnoringSafeArea(.all)
        }
        .zIndex(1)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .transition(.move(edge: .bottom))
        .frame(maxWidth: .infinity)
        .offset(y: max(-negativeOffset, 0))
        .fixedSize(horizontal: false, vertical: true)
        .edgesIgnoringSafeArea(.all)
        .highPriorityGesture(
            DragGesture(coordinateSpace: .local)
                .onEnded { value in
                    guard allGestures else { return }
                    if value.predictedEndLocation.y - value.startLocation.y > 50,
                       allDismiss {
                        show = false
                    } else {
                        withAnimation(bottomSheetAnimation) {
                            positiveOffset = 0.0
                            negativeOffset = 0.0
                        }
                    }
                }
                .onChanged { value in
                    guard allGestures else { return }
                    var translation = value.translation.height
                    translation.negate()
                    positiveOffset += translation
                    negativeOffset = translation
                }
        )
    }
    
    private func resetBottomSheet(_ show: Bool) {
        withAnimation(bottomSheetAnimation) {
            shouldShow = show
        }
        positiveOffset = 0.0
        negativeOffset = 0.0
    }

}
