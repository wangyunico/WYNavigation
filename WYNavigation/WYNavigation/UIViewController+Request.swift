//
//  UIViewController+Request.swift
//  WYNavigation
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import Foundation

private var kwyNavigationRequestKey: Void?


//class RequestWrapper< T: WYNavigationRequest>:NSObject {
//    var value:T?
//    init(value:T?){
//        super.init()
//        self.value = value
//    }
//}






public extension UIViewController{
    
    public   var request:WYNavigationRequest?{
        get {
            return objc_getAssociatedObject(self, &kwyNavigationRequestKey) as? WYNavigationRequest
        }
        set {
            objc_setAssociatedObject(self, &kwyNavigationRequestKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //    var request:WYNavigationRequest?{
    //        get {
    //            let requestWrapper = objc_getAssociatedObject(self, &kwyNavigationRequestKey) as? RequestWrapper
    //            return requestWrapper?.value
    //        }
    //        set{
    //            objc_setAssociatedObject(self, &kwyNavigationRequestKey, RequestWrapper(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    //        }
    //    }
}