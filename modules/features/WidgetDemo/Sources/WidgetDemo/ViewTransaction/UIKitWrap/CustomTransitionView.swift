// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

protocol ViewTransitionProtocol {
    
    func transition(
        operation: UINavigationController.Operation
    ) -> UIViewControllerAnimatedTransitioning?
    
}

struct CustomTransitionView<Content: View>: UIViewControllerRepresentable {
    
    let content: () -> Content
    let transitionProvider: ViewTransitionProtocol?
    
    init(
        transitionProvider: ViewTransitionProtocol?,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.transitionProvider = transitionProvider
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> CustomTransitionHostingController<Content> {
        let vc = CustomTransitionHostingController<Content>(
            transitionProvider: transitionProvider,
            rootView: content()
        )
        
        return vc
    }
    
    func updateUIViewController(
        _ uiViewController: CustomTransitionHostingController<Content>,
        context: Context
    ) {
        uiViewController.transitionProvider = transitionProvider
    }
}

