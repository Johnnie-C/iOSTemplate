// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public extension UIView {
    
    func shakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(
            cgPoint: CGPoint(
                x: self.center.x - 10.0,
                y: self.center.y
            )
        )
        animation.toValue = NSValue(
            cgPoint: CGPoint(
                x: self.center.x + 10.0,
                y: self.center.y
            )
        )
        self.layer.add(animation, forKey: "position")
    }
    
    static func animation(
        withDuration duration: TimeInterval = 0.25,
        delay: TimeInterval = 0,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        animate(
            withDuration: duration,
            delay: delay,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
    
    static func lightSpringAnimation(
        withDuration duration: TimeInterval = 0.25,
        delay: TimeInterval = 0,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) { 
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations: animations,
            completion: completion
        )
    }
    
    static func strongSpringAnimation(
        withDuration duration: TimeInterval = 0.25,
        delay: TimeInterval = 0,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 2,
            options: .curveEaseOut,
            animations: animations,
            completion: completion
        )
    }
    
}
