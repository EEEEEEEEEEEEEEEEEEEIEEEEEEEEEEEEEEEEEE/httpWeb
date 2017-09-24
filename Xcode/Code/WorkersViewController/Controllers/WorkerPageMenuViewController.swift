//
//  WorkerPageMenuViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/21.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import PageMenu

class WorkerPageMenuViewController: UIViewController, CAPSPageMenuDelegate {
    
    var pageMenu: CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        var controllerArray : [UIViewController] = []
        
        let ethController = WorkerETHViewController()
        ethController.title = "ETH"
        controllerArray.append(ethController)
        
        let btcController = WorkerBTCViewController()
        btcController.title = "BTC"
        controllerArray.append(btcController)
        
        let ltcController = WorkerLTCViewController()
        ltcController.title = "LTC"
        controllerArray.append(ltcController)
//        ltcController.tabBarItem.badgeValue = "120"
//        ltcController.tabBarItem.badgeColor = UIColor.red
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .scrollMenuBackgroundColor(RGBCOLOR(r: 32, 170, 216)),
            .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectionIndicatorColor(UIColor.darkGray),
            .menuMargin(20.0),
            .menuHeight(40.0),
            .selectedMenuItemLabelColor(UIColor.darkGray),
            .unselectedMenuItemLabelColor(UIColor.white),
            .menuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize scroll menu
        UIApplication.shared.statusBarView?.backgroundColor = RGBCOLOR(r: 32, 170, 216)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 20.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu?.delegate = self
        self.view.addSubview((pageMenu?.view)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
//        print("将要移动")
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
//        print("已经移动")
    }
}

















