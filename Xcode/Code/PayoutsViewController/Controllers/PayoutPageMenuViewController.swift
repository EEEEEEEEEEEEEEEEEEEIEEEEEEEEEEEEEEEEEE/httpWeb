//
//  PayoutPageMenuViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import PageMenu

class PayoutPageMenuViewController: UIViewController, CAPSPageMenuDelegate {
    
    var pageMenu: CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var controllerArray: [UIViewController] = []
        
        
        let ethController = PayoutBaseViewController()
        ethController.payoutViewModel.coinTypeRxIn.value = EnumCurrency.ETH
        ethController.title = EnumCurrency.ETH.description
        controllerArray.append(ethController)
        
        let btcController = PayoutBaseViewController()
        btcController.payoutViewModel.coinTypeRxIn.value = EnumCurrency.BTC
        btcController.title = EnumCurrency.BTC.description
        controllerArray.append(btcController)
        
        let ltcController = PayoutBaseViewController()
        ltcController.payoutViewModel.coinTypeRxIn.value = EnumCurrency.LTC
        ltcController.title = EnumCurrency.LTC.description
        controllerArray.append(ltcController)
        
        
//        let ethController = PayoutETHViewController()
//        ethController.title = "ETH"
//        controllerArray.append(ethController)
        
//        let btcController = PayoutBTCViewController()
//        btcController.title = "BTC"
//        controllerArray.append(btcController)
//        
//        let ltcController = PayoutLTCViewController()
//        ltcController.title = "LTC"
//        controllerArray.append(ltcController)
        
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
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray,
                                frame: CGRect(x: 0.0, y: 20.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT),
                                pageMenuOptions: parameters)
        pageMenu?.delegate = self
        self.view.addSubview((pageMenu?.view)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        //        print("将要移动")
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        //        print("已经移动")
    }
}
