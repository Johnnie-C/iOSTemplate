//
//  ScrollAnchor.swift
//  
//
//  Created by Johnnie Cheng on 27/10/22.
//

import SwiftUI

public extension View {

    /// Workaround for scroll view to scroll to a specific element
    /// Assign id to element directly will cause weird behaviour that view shifting to left (ignoring any padding on left)
    func scrollAnchor(id: AnyHashable) -> some View {
        modifier(ScrollAnchorViewModifier(id: id))
    }
    
}

public struct ScrollAnchorViewModifier: ViewModifier {
    
    var id: AnyHashable
    
    public func body(content: Content) -> some View {
        ZStack {
            Text("").id(id)
            content
        }
    }
    
}
