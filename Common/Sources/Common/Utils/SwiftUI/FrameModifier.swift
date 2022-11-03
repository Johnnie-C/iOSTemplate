//
//  FrameModifier.swift
//  
//
//  Created by Johnnie Cheng on 27/10/22.
//

import SwiftUI

public extension View {
    
    func observeFrame(
        in space: CoordinateSpace,
        onChange: @escaping (CGRect) -> Void
    ) -> some View {
        modifier(FrameModifier(space: space, onChange: onChange))
    }
    
}

public struct FrameModifier: ViewModifier {
    
    var space: CoordinateSpace
    var onChange: (CGRect) -> Void
    
    public func body(content: Content) -> some View {
        content.background(GeometryReader { geometry -> Color in
            onChange(geometry.frame(in: space))
            return Color.clear
        })
    }
    
}
