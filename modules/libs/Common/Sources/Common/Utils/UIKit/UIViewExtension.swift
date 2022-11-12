//
//  UIViewExtension.swift
//
//  Created by Johnnie Cheng on 29/4/21.
//

import UIKit

public extension UIView {
    
    @discardableResult func addHeightConstraint(_ height: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraintHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        NSLayoutConstraint.activate([constraintHeight])
        
        return constraintHeight
    }
    
    @discardableResult func addWidthConstraint(_ width: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraintHeight = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
        NSLayoutConstraint.activate([constraintHeight])
        
        return constraintHeight
    }
    
    func center(inSuperView superView: UIView, width: Float, height: Float, verticalAdjustmentConstant: CGFloat = 0.0) {
        superView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintWidth = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(width))
        let constraintHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(height))
        NSLayoutConstraint.activate([constraintWidth, constraintHeight])
        
        if #available(iOS 11.0, *), let scrollView = superView as? UIScrollView {
            centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerYAnchor, constant: verticalAdjustmentConstant).isActive = true
        } else {
            let constraintX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1.0, constant: 0)
            let constraintY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1.0, constant: verticalAdjustmentConstant)
            NSLayoutConstraint.activate([constraintX, constraintY])
        }
    }
    
    func wrap(subview: UIView, usingInsets insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: subview, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: insets.left),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: subview, attribute: .trailing, multiplier: 1, constant: insets.right),
            NSLayoutConstraint(item: subview, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: insets.top),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: subview, attribute: .bottom, multiplier: 1, constant: insets.bottom)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}


// MARK: - animation
extension UIView {

    func performShakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10.0, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    

    static func springAnimate(animations: @escaping () -> Void,
                              completion: ((Bool) -> Void)? = nil)
    {
        UIView.animate(withDuration: 0.3, delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 2,
                       options: .curveEaseOut,
                       animations: animations,
                       completion: completion)
    }
    
}
