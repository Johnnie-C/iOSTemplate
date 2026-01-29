// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        modifier: (Self) -> Content
    ) -> some View {
        if condition {
            modifier(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func ifNotNil<Content: View, T>(
        _ object: T?,
        modifier: (Self, T) -> Content
    ) -> some View {
        if let object {
            modifier(self, object)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func ifNotEmpty<Content: View, T>(
        _ array: [T]?,
        modifier: (Self, [T]) -> Content
    ) -> some View {
        if let array, !array.isEmpty{
            modifier(self, array)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func apply<Content: View>(
        @ViewBuilder modifier: (Self) -> Content
    ) -> some View {
        modifier(self)
    }
    
}
