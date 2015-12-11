//
//  WYBaseAnimator.swift
//  WYNavigation
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import UIKit
import Foundation

public class WYBaseAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    let duration:Double
    var presenting = true
    var dismissCompletion: (()->())?
    
    required public init(duration:Double){
        self.duration = duration;
        super.init()
    }
    
    
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let contentView = transitionContext.containerView()!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        self.animationTransition(transitionContext, containerView: contentView, fromView: fromView, toView: toView)
    }
    
    public func animationTransition(transitionContext:UIViewControllerContextTransitioning,
        containerView: UIView, fromView:UIView, toView: UIView){
            fatalError(" animationTansition should be overrided")
    }
    
}
