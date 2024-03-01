// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public protocol ViewTransitionProtocol {
    
    func transition(
        operation: UINavigationController.Operation
    ) -> UIViewControllerAnimatedTransitioning?
    
}
