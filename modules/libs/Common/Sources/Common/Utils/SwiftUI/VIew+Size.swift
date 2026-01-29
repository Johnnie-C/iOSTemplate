// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    func observeFrame(
        in space: CoordinateSpace = .global,
        onChange: @escaping (CGRect) -> Void
    ) -> some View {
        modifier(FrameModifier(space: space, onChange: onChange))
    }
    
    @ViewBuilder
    func measureSize(
        onChange: @escaping (CGSize) -> Void
    ) -> some View {
        onGeometryChange(for: CGSize.self) { proxy in
            proxy.size
        } action: { size in
            onChange(size)
        }
    }
    
}

public struct FrameModifier: ViewModifier {
    
    var space: CoordinateSpace
    var onChange: (CGRect) -> Void
    
    public func body(content: Content) -> some View {
        content.background(GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                onChange(geometry.frame(in: space))
            }
            return Color.clear
        })
    }
    
}
