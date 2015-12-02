//
//  WYNavigationRequest.swift
//  WYNavigation
//
//  Created by apple on 15/11/29.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import Foundation

// 需要两种类型就可以了，一种 requestId, 一种就是request的Data，设置为 [String: Object]类型

public class WYNavigationRequest: NSObject,WYNavigationUUID{
    
    private let _requestId:String = {
        return NSUUID().UUIDString.stringByReplacingOccurrencesOfString("-", withString: "")
    }()
    
    public var uuid:String{
        return _requestId
    }
    
    public var requestData = [String: Any]()
    
}


public protocol WYNavigationUUID {
    
    var uuid:String {get}
}