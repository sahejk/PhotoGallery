//
//  PresentAnimator.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 25/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation
import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  let duration = 0.5
  let originFrame: CGRect
  let isPresenting: Bool

  init(isPresenting: Bool, originFrame: CGRect) {
    self.originFrame = originFrame
    self.isPresenting = isPresenting

  }
  
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let containerView = transitionContext.containerView
    
    
    let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
    let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
    

    let detailView = self.isPresenting ? toView : fromView
    
    if self.isPresenting {
      containerView.addSubview(toView)
    } else {
      containerView.insertSubview(toView, belowSubview: fromView)
    }
    
    detailView.frame.origin = self.isPresenting ? self.originFrame.origin : CGPoint(x: 0, y: 0)
    detailView.frame.size.width = self.isPresenting ? self.originFrame.size.width : containerView.bounds.width
    detailView.layoutIfNeeded()
    
    for view in detailView.subviews {
      if !(view is UIImageView) {
        view.alpha = isPresenting ? 0.0 : 1.0
      }
    }
    
    UIView.animate(withDuration: self.duration, animations: { () -> Void in
      detailView.frame = self.isPresenting ? containerView.bounds : self.originFrame
      detailView.layoutIfNeeded()
      
      for view in detailView.subviews {
        if !(view is UIImageView) {
          view.alpha = self.isPresenting ? 1.0 : 0.0
        }
      }
    }) { (completed: Bool) -> Void in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
  
}
