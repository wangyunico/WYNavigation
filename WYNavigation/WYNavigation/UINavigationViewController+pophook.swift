//
//  UINavigationViewController+pophook.swift
//  WYNavigation
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import Foundation


public extension UINavigationController{
    
    class func xxx_swizzlepopViewControllerAnimated(){
        
        struct swizzleToken{
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&swizzleToken.onceToken) {
            let cls: AnyClass! = UINavigationController.self
            let originalSelector = Selector("popViewControllerAnimated:")
            let  swizzeledSelctor = Selector("xxx_popViewControllerAnimated:")
            let originalMethod = class_getInstanceMethod(cls, originalSelector)
            let swizzledMethod = class_getInstanceMethod(cls, swizzeledSelctor)
            assert(originalMethod != nil)
            if class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)){
                class_replaceMethod(cls, swizzeledSelctor, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            }else{
                
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
            
        }
    }
    
    
    func xxx_popViewControllerAnimated(animated:Bool){
        // before 
        if let topVC = self.topViewController {
            if !WYPageManager.defaultManger.pageStack.contains(topVC) {
                // 表明当前UI中不存在该vc，那么将这个VC加入到栈中
                if let lastViewController = WYPageManager.defaultManger.pageStack.last{
                    lastViewController.toVC = topVC
                    topVC.fromVC = lastViewController
                }
                WYPageManager.defaultManger.pageStack.append(topVC)
            }
        }
        
        xxx_popViewControllerAnimated(animated)
        // after
        if let topVC = self.topViewController {
            // 获得最上面的vc
            if  let index = WYPageManager.defaultManger.pageStack.indexOf(topVC){
                // 获得Index 
                if index < WYPageManager.defaultManger.pageStack.count - 1 {
                    // topVC 不是栈顶的元素，需要将当前栈顶的元素移除
                    if  let lastVC = WYPageManager.defaultManger.pageStack.last {
                        lastVC.fromVC = nil
                        WYPageManager.defaultManger.pageStack.removeLast()
                        topVC.toVC = nil 
                    }
                }
            }
        }
        
    }
    
    
}