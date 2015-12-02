//
//  UIViewController+VChierarchy.swift
//  WYNavigation
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import Foundation


private var kFromViewController:Void?
private var kToViewController:Void?


public extension UIViewController {
    
    public var toVC:UIViewController?{
        get{
            return objc_getAssociatedObject(self, &kToViewController) as? UIViewController
        }
        set{
            objc_setAssociatedObject(self, &kToViewController, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public  var fromVC: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &kFromViewController) as? UIViewController
        }
        set {
            objc_setAssociatedObject(self, &kFromViewController, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}




public  extension UIViewController {
    
    public func pushPage(newPage:UIViewController, request:WYNavigationRequest? = nil,
        respose: Response? = nil ){
            WYPageManager.defaultManger.pushPage(newPage, currentPage: self, request: request, response: response)
    }
    
    public func popPage(response:WYNavigationResponse? = nil){
        WYPageManager.defaultManger.popPage(self, response: response)
    }
    
    public func popPageToIndex(index:NSInteger, response: WYNavigationResponse? = nil) {
        
        WYPageManager.defaultManger.popPageToIndex(index, currentPage: self, response: response)
    }
    
}







