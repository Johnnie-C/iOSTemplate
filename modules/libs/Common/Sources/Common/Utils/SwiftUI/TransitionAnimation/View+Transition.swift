// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    func transitionAnimation(
        transitionProvider: Binding<ViewTransitionProtocol?>
    ) -> some View {
        modifier(TransitionModifier(transitionProvider: transitionProvider))
    }
    
}

public struct TransitionModifier: ViewModifier {
    
    @Binding var transitionProvider: ViewTransitionProtocol?
    
    public func body(content: Content) -> some View {
        CustomTransitionView(transitionProvider: transitionProvider) {
            content
        }
    }
    
}
