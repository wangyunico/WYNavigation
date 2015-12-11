//
//  UIViewController+Transition.swift
//  WYNavigation
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import Foundation


private var kUIViewControllerTransion:Void?

extension UIViewController:UINavigationControllerDelegate {
    
    public  var transition:WYBaseAnimator?{
        get {
            return objc_getAssociatedObject(self, &kUIViewControllerTransion) as? WYBaseAnimator
        }
        set {
            objc_setAssociatedObject(self, &kUIViewControllerTransion, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch (operation){
        case.Pop:
            self.transition?.presenting = false
        case .Push:
            self.transition?.presenting = true 
        default:
            break
        }
        return self.transition
    }
}