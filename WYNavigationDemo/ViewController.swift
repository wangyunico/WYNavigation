//
//  ViewController.swift
//  WYNavigationDemo
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 Neusoft. All rights reserved.
//

import UIKit
import WYNavigation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blueColor()
        let button = UIButton(frame: CGRectMake(100,100,100,100))
        button.backgroundColor = UIColor.redColor()
        self.view.addSubview(button)
        button.addTarget(self, action: "changePage", forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changePage(){
        let page = SecondViewController()
        pushPage(page)
    }
}

