//
//  PopAnimator.swift
//  BreakingBadCharacters
//
//  Created by Voro on 2.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
        -> TimeInterval {
      return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let sourceView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : sourceView.frame
        let finalFrame = presenting ? sourceView.frame : originFrame

        let xScaleFactor = presenting ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width

        let yScaleFactor = presenting ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

        if presenting {
          sourceView.transform = scaleTransform
          sourceView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
          sourceView.clipsToBounds = true
        }

        sourceView.layer.cornerRadius = presenting ? 20.0 : 0.0
        sourceView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(sourceView)

        UIView.animate(
          withDuration: duration,
          delay: 0.0,
          usingSpringWithDamping: 0.6,
          initialSpringVelocity: 0.7,
          animations: {
            sourceView.transform = self.presenting ? .identity : scaleTransform
            sourceView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            sourceView.layer.cornerRadius = !self.presenting ? 5.0 : 0.0
          }, completion: { _ in
            if !self.presenting {
              self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
    }
}
