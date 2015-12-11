//
//  UIViewController+Response.swift
//  WYNavigation
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import Foundation


public typealias Response = (resp:WYNavigationResponse?) -> ()
private var kwyNavigationResponseKey: Void?
public extension UIViewController  {
    
    
    private class ResponseWrapper:NSObject{
        var value:Response?
        init(_ value:Response?){
            super.init()
            self.value = value
        }
    }
    
    public  var response:Response?{
        
        get{
            let wrapper = objc_getAssociatedObject(self, &kwyNavigationResponseKey) as? ResponseWrapper
            return wrapper?.value
        }
        set{
            objc_setAssociatedObject(self, &kwyNavigationResponseKey, ResponseWrapper(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}