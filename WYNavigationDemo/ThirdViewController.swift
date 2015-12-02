//
//  ThirdViewController.swift
//  WYNavigationDemo
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 Neusoft. All rights reserved.
//

import UIKit 

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        let button = UIButton(frame: CGRectMake(100,100,100,100))
        button.backgroundColor = UIColor.redColor()
        self.view.addSubview(button)
        button.addTarget(self, action: "changePage", forControlEvents: .TouchUpInside)
    }
    
    
    func changePage(){
        self.popPage()
    }
}
