// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import SwiftUI

class CustomTransitionHostingController<Content: View>: UIHostingController<Content>, UINavigationControllerDelegate  {
    
    var transitionProvider: ViewTransitionProtocol?
    private var operation: UINavigationController.Operation? = nil
    
    init(
        transitionProvider: ViewTransitionProtocol?,
        rootView: Content
    ) {
        self.transitionProvider = transitionProvider
        super.init(rootView: rootView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return transitionProvider?.transition(operation: operation)
    }
    
}
