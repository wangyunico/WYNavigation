//
//  WYNavigationResponse.swift
//  WYNavigation
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import Foundation


public enum Type:Int {
    case Number
    case String
    case Bool
    case Array
    case Dictionary
    case Blob
    case Null
}

public class WYNavigationResponse: NSObject {
    
    private var rawArray:[AnyObject] = []
    private var rawDictionary:[String:AnyObject] = [:]
    private var rawString:String = ""
    private var rawNumber:NSNumber = 0
    private var rawNull:NSNull = NSNull()
    private var rawData:NSData = NSData()
    private var _type:Type = .Null
    public var object:AnyObject {
        get{
            switch self.type {
            case .Array:
                return self.rawArray
            case .Dictionary:
                return self.rawDictionary
            case .String:
                return self.rawString
            case .Number:
                return self.rawNumber
            case .Bool:
                return self.rawNumber
            case .Blob:
                return self.rawData
            default:
                return self.rawNull
            }
        }
        set {
            switch newValue {
            case let number as NSNumber:
                if number.isBool{
                    _type = .Bool
                }else {
                    _type = .Number
                }
                self.rawNumber = number
            case let string as String:
                _type = .String
                rawString = string
            case _ as NSNull:
                _type = .Null
            case let array as [AnyObject]:
                _type = .Array
                rawArray = array
            case let dic as [String:AnyObject]:
                _type = .Dictionary
                rawDictionary = dic
            case let data as NSData where data is TranferData:
                _type = .Blob
                rawData = data
            default:
                _type = .Null
            }
        }
    }
    
    required   public init<T>(_ object:T){
        super.init()
    }
    public var type:Type {get{ return _type }}
}




public protocol TranferData {
    
    func tranferData<T>() -> T
}




private let trueNumber = NSNumber(bool: true)
private let falseNumber = NSNumber(bool: false)
private let trueObjCType = String.fromCString(trueNumber.objCType)
private let falseObjCType = String.fromCString(falseNumber.objCType)

extension NSNumber {
    var  isBool:Bool {
        get {
            let objcType = String.fromCString(self.objCType)
            if (self.compare(trueNumber) == NSComparisonResult.OrderedSame && objcType == trueObjCType) || (self.compare(falseNumber) == NSComparisonResult.OrderedSame && objcType == falseObjCType){
                return true
            }else{
                return false
            }
        }
    }
}

