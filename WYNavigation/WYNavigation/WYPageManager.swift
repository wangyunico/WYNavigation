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
    private var _navigationViewController:UINavigationController!{
        didSet{
            if  let appDelegate = UIApplication.sharedApplication().delegate {
                appDelegate.window!!.rootViewController = _navigationViewController
            }
        }
    }
    // 相当于ViewController的堆栈
    private var pageStack = [UIViewController]()
    // 获取根ViewController
    public var rootViewController:UIViewController?{ get{return _rootViewController}}
    // 获取当前pages
    public var pages:[UIViewController]{get {return pageStack}}
    
    static let defaultManger:WYPageManager = WYPageManager()
    
    private override init() {
        super.init()
        // 限制访问
        _navigationViewController = UINavigationController.init()
    }
    
    
    // MARK: PageStackCalls
    /**
    设置根节点,根节点用于设置初始化的页面
    
    - parameter vc: ViewController
    */
    func setRootViewController(vc:UIViewController){
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
    func pushPage(topage:UIViewController, currentPage:UIViewController, request:WYNavigationRequest? = nil , response:Response? = nil ){
        guard NSThread.currentThread().isMainThread else {
            fatalError(" Push Page should in mainThread")
        }
        topage.request = request
        currentPage.response = response
        topage.fromVC = currentPage
        currentPage.toVC = topage
        _navigationViewController.pushViewController(topage, animated: true)
        self.pageStack.append(topage)
    }
    
    /**
     弹出页面
     
     - parameter page:     当前弹出的页面
     - parameter response: 页面的回调
     */
    func popPage(page:UIViewController, response:WYNavigationResponse? = nil){
        guard NSThread.currentThread().isMainThread else {
            fatalError(" Pop Page should in mainThread")
        }
        if let currentPage = self.pageStack.last {
            if let previousPage = currentPage.fromVC {
                _navigationViewController.popToViewController(previousPage, animated:true)
                previousPage.toVC = nil
                previousPage.response?(resp: response)
            }
            currentPage.fromVC = nil
            currentPage.response = nil
            self.pageStack.removeLast()
        }
    }
    
    /**
     弹出到Index 的位置
     - parameter index:       索引
     - parameter currentPage: 当前页面
     - parameter response:    响应
     */
    func popPageToIndex(index:NSInteger, currentPage:UIViewController, response:WYNavigationResponse? = nil ){
        
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
