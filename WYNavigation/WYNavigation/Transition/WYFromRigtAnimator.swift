//
//  WYFromRigtAnimator.swift
//  WYNavigation
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import UIKit 

public class WYFromRigtAnimator: WYBaseAnimator {
    
    public convenience init() {
        self.init(duration: 0.25)
    }
    public override func animationTransition(transitionContext:UIViewControllerContextTransitioning,
        containerView: UIView, fromView:UIView, toView: UIView){
            if self.presenting {
                // push 
                toView.frame = CGRectOffset(toView.frame, CGRectGetWidth(toView.frame), 0)
                containerView.addSubview(toView)
                UIView.animateWithDuration(self.duration, delay: 0, options: .CurveEaseIn, animations: {
                    toView.frame = CGRectOffset(toView.frame, -CGRectGetWidth(toView.frame), 0)
                    fromView.alpha = 0.2
                    }, completion: { _ in
                        fromView.removeFromSuperview()
                        fromView.alpha = 1.0
                        transitionContext.completeTransition(true)
                })
            }else{
                containerView.addSubview(toView)
                containerView.sendSubviewToBack(toView)
                UIView.animateWithDuration(self.duration, delay: 0, options: .CurveEaseOut, animations: {
                    fromView.frame = CGRectOffset(fromView.frame, CGRectGetWidth(fromView.frame), 0)
                    }, completion: { _ in
                        fromView.removeFromSuperview()
                        transitionContext.completeTransition(true)
                })
            }
            
    }
    
}
