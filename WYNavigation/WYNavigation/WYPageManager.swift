//
//  WYPageManager.swift
//  WYNavigation
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import UIKit


public class WYPageManager: NSObject {
    
    private var _rootViewController:UIViewController?
    private let _navigationViewController:UINavigationController = {
        let navigationVIewController = UINavigationController()
        if  let appDelegate = UIApplication.sharedApplication().delegate {
            appDelegate.window!!.rootViewController = navigationVIewController
        }
        return navigationVIewController
    }()
    // 相当于ViewController的堆栈
    internal var pageStack = [UIViewController]()
    // 获取根ViewController
    public var rootViewController:UIViewController?{ get{return _rootViewController}}
    // 获取当前pages
    public var pages:[UIViewController]{get {return pageStack}}
    
    public static let defaultManger:WYPageManager = WYPageManager()
    
    private override init() {
        super.init()
        UINavigationController.xxx_swizzlepopViewControllerAnimated()
    }
    
    
    // MARK: PageStackCalls
    /**
    设置根节点,根节点用于设置初始化的页面
    
    - parameter vc: ViewController
    */
    public  func setRootViewController(vc:UIViewController){
        guard (self.rootViewController == nil) else {
            return
        }
        _rootViewController = vc
        _navigationViewController.viewControllers = [vc]
        self.pageStack.append(vc)
    }
    
    
    
    /**
     将Page 增加到UI的栈中
     
     - parameter topage:       要跳转指向的页面
     - parameter currentPage:  当前的页面
     - parameter request:      页面的请求
     - parameter response:     页面的回调
     */
    public   func pushPage(topage:UIViewController, currentPage:UIViewController, request:WYNavigationRequest? = nil , response:Response? = nil ){
        guard NSThread.currentThread().isMainThread else {
            fatalError(" Push Page should in mainThread")
        }
        if !self.pageStack.contains(currentPage) {
            if let vc = self.pageStack.last{
                vc.toVC = currentPage
                currentPage.fromVC = vc
            }
            self.pageStack.append(currentPage)
        }
        topage.request = request
        currentPage.response = response
        topage.fromVC = currentPage
        currentPage.toVC = topage
        _navigationViewController.delegate = currentPage
        _navigationViewController.pushViewController(topage, animated: true)
        self.pageStack.append(topage)
    }
    
    /**
     弹出页面
     
     - parameter page:     当前弹出的页面
     - parameter response: 页面的回调
     */
    public   func popPage(page:UIViewController, response:WYNavigationResponse? = nil){
        guard NSThread.currentThread().isMainThread else {
            fatalError(" Pop Page should in mainThread")
        }
        if self.pageStack.contains(page){
            if let currentPage = self.pageStack.last {
                if let previousPage = currentPage.fromVC {
                    _navigationViewController.delegate = previousPage
                    _navigationViewController.popToViewController(previousPage, animated:true)
                    previousPage.toVC = nil
                    previousPage.response?(resp: response)
                }
                currentPage.fromVC = nil
                currentPage.response = nil
                self.pageStack.removeLast()
            }
        }else {
            if let previousPage = self.pageStack.last{
                _navigationViewController.delegate = previousPage
                _navigationViewController.popToViewController(previousPage, animated: true)
                previousPage.toVC = nil
                previousPage.response?(resp: response)
            }
            page.fromVC = nil
            page.response = nil 
        }
    }
    
    /**
     弹出到Index 的位置
     - parameter index:       索引
     - parameter currentPage: 当前页面
     - parameter response:    响应
     */
    public  func popPageToIndex(index:NSInteger, currentPage:UIViewController, response:WYNavigationResponse? = nil ){
        
        guard NSThread.currentThread().isMainThread else {
            fatalError(" Pop Page should in mainThread")
        }
        guard index < self.pages.count  else {
            fatalError(" Pop Array Action over the stack boundary ")
        }
        let previousViewContoller = self.pages[index]
        self.pages.filter{ self.pages.indexOf($0)! > index}.forEach { $0.fromVC = nil; $0.toVC = nil }
        _navigationViewController.popToViewController(previousViewContoller, animated: true)
        previousViewContoller.toVC = nil
        previousViewContoller.response?(resp: response)
        self.pageStack.removeRange( index+1 ..< self.pages.count)
    }
    
}
