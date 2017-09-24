//
//  MainViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/15.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class MainViewController: ESTabBarController {

//    let kindVC   = KindViewController()
    let kindVC   = KindsViewController()
    let poolVC   = PoolViewController()
    let workerVC = WorkerPageMenuViewController()
    let payoutVC = PayoutPageMenuViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 系统方式
        
//        homeVC.tabBarItem   = UITabBarItem.init(title: "ETH", image: UIImage(named: "ETHNormal"), selectedImage: UIImage(named: "ETHSelect"))
//        stopVC.tabBarItem   = UITabBarItem.init(title: "Stop", image: UIImage(named: "stopNormal"), selectedImage: UIImage(named: "stopSelect"))
//        workerVC.tabBarItem = UITabBarItem.init(title: "Worker", image: UIImage(named: "workerNormal"), selectedImage: UIImage(named: "workerSelect"))
//        payoutVC.tabBarItem = UITabBarItem.init(title: "Payout", image: UIImage(named: "sellNormal"), selectedImage: UIImage(named: "sellSelect"))
//        
//        self.tabBar.shadowImage = nil
//        self.viewControllers = [homeVC, stopVC, workerVC, payoutVC]
        
        workerVC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Worker", image: UIImage(named: "workerNormal"), selectedImage: UIImage(named: "workerSelect"))
        payoutVC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Payout", image: UIImage(named: "sellNormal"), selectedImage: UIImage(named: "sellSelect"))
        poolVC.tabBarItem   = ESTabBarItem.init(ExampleBouncesContentView(), title: "Pool", image: UIImage(named: "poolNormal"), selectedImage: UIImage(named: "poolSelect"))
        kindVC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Config", image: UIImage(named: "kindNormal"), selectedImage: UIImage(named: "kindSelect"))
        
        if let tabBarItem = poolVC.tabBarItem as? ESTabBarItem {
            tabBarItem.badgeValue = "5"
        }
        
        
        
        self.tabBar.shadowImage = nil
        self.viewControllers = [workerVC, payoutVC, poolVC, kindVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
