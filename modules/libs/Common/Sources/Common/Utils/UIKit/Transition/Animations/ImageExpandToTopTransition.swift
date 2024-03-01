// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public class ImageExpandToTopTransition: ViewTransitionProtocol {
    
    private let fromFrame: CGRect
    private let toFrame: CGRect
    private let transitionImage: UIImage?
    private let duration: Double
    private let onTransitionStart: ((UINavigationController.Operation) -> Void)?
    private let onTransitionComplete: ((UINavigationController.Operation) -> Void)?
    
    private var transition: BaseImageExpandToTopPushTransition?
    
    public init(
        fromFrame: CGRect = .zero,
        toFrame: CGRect = .zero,
        duration: Double = 0.4,
        transitionImage: UIImage? = nil,
        onTransitionStart: ((UINavigationController.Operation) -> Void)? = nil,
        onTransitionComplete: ((UINavigationController.Operation) -> Void)? = nil
    ) {
        self.fromFrame = fromFrame
        self.toFrame = toFrame
        self.duration = duration
        self.transitionImage = transitionImage
        self.onTransitionStart = onTransitionStart
        self.onTransitionComplete = onTransitionComplete
    }
    
    public func transition(
        operation: UINavigationController.Operation
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            transition = ImageExpandToTopPushTransition(
                fromFrame: fromFrame,
                toFrame: toFrame,
                transitionImage: transitionImage ?? UIImage(),
                operation: operation,
                duration: duration,
                onTransitionStart: onTransitionStart,
                onTransitionComplete: onTransitionComplete
            )
        case .pop:
            transition = ImageExpandToTopPopTransition(
                fromFrame: fromFrame,
                toFrame: toFrame,
                transitionImage: transitionImage ?? UIImage(),
                operation: operation,
                duration: duration,
                onTransitionStart: onTransitionStart,
                onTransitionComplete: onTransitionComplete
            )
        default:
            transition = nil
        }
        
        return transition
    }
    
}

fileprivate class BaseImageExpandToTopPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let fromFrame: CGRect
    let toFrame: CGRect
    let transitionImage: UIImage
    let operation: UINavigationController.Operation
    let duration: Double
    let onTransitionStart: ((UINavigationController.Operation) -> Void)?
    let onTransitionComplete: ((UINavigationController.Operation) -> Void)?
    
    init(
        fromFrame: CGRect,
        toFrame: CGRect,
        transitionImage: UIImage,
        operation: UINavigationController.Operation,
        duration: Double,
        onTransitionStart: ((UINavigationController.Operation) -> Void)? = nil,
        onTransitionComplete: ((UINavigationController.Operation) -> Void)? = nil
    ) {
        self.fromFrame = fromFrame
        self.toFrame = toFrame
        self.transitionImage = transitionImage
        self.operation = operation
        self.duration = duration
        self.onTransitionStart = onTransitionStart
        self.onTransitionComplete = onTransitionComplete
    }
    
    func getTransitionImageView(frame: CGRect) -> UIImageView {
        let imageView = UIImageView(image: transitionImage)
        imageView.frame = frame
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 5
        return imageView
    }
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return duration
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        transitionContext.completeTransition(true)
    }
    
}

fileprivate class ImageExpandToTopPushTransition: BaseImageExpandToTopPushTransition {
    
    override func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let transitionImageView = getTransitionImageView(frame: fromFrame)
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        toView?.alpha = 0
        
        if let fromView = fromView {
            containerView.addSubview(fromView)
        }
        if let toView = toView {
            containerView.addSubview(toView)
        }
        containerView.addSubview(transitionImageView)
        
        onTransitionStart?(.push)
        
        UIView.lightSpringAnimation(
            withDuration: duration
        ) { [weak self] in
            guard let self = self else { return }
            
            transitionImageView.frame = self.toFrame
            fromView?.alpha = 0
            toView?.alpha = 1
        } completion: { [weak self] _ in
            fromView?.alpha = 1
            transitionImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
            self?.onTransitionComplete?(.push)
        }
    }
    
}

fileprivate class ImageExpandToTopPopTransition: BaseImageExpandToTopPushTransition {
    
    override func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let transitionImageView = getTransitionImageView(frame: toFrame)
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        toView?.alpha = 0
        
        if let fromView = fromView {
            containerView.addSubview(fromView)
        }
        if let toView = toView {
            containerView.addSubview(toView)
        }
        containerView.addSubview(transitionImageView)
        
        onTransitionStart?(.pop)
        
        UIView.lightSpringAnimation(
            withDuration: duration
        ) { [weak self] in
            guard let self = self else { return }
            
            transitionImageView.frame = self.fromFrame
            fromView?.alpha = 0
            toView?.alpha = 1
        } completion: { [weak self] _ in
            fromView?.alpha = 1
            transitionImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
            self?.onTransitionComplete?(.pop)
        }
    }
    
}
