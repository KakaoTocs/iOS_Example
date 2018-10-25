//
//  CustomAnimator.swift
//  NavigationPopAnimation
//
//  Created by Jinu Kim on 24/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    var image: UIImage
    
    public let CustomAnimatorTag = 99
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, image: UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        print(originFrame)
        self.image = image
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        
        guard let imageView = detailView.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
        imageView.image = image
        imageView.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : imageView.frame)
        transitionImageView.image = image
        
        container.addSubview(transitionImageView)
        
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? imageView.frame : self.originFrame
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            imageView.alpha = 1
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}
