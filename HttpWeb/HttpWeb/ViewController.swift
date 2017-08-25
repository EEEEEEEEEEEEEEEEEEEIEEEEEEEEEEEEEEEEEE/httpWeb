//
//  ViewController.swift
//  HttpWeb
//
//  Created by Hanxun on 2017/8/25.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ChameleonFramework
import RKNotificationHub
import MJRefresh

class ViewController: UIViewController {

    let tableView: UITableView! = nil
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.randomFlat()
        self.view.addSubview(myView)
        
        let baged = RKNotificationHub.init(view: myView)
        baged?.increment()
        baged?.increment(by: 134)
        baged?.pop()
        print("\(baged?.count)")
        baged?.hideCount()
        
        header.setRefreshingTarget(self, refreshingAction: #selector(actin))
        self.tableView.mj_header = header
        self.tableView.mj_footer = footer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actin() {
        print("123")
    }

}

