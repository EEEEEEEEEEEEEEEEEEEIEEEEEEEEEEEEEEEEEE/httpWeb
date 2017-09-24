//
//  CommonDefine.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/8.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let FIT_HEIGHT    = SCREEN_HEIGHT / 375.0
let FIT_WIDTH     = SCREEN_WIDTH  / 667.0


//MARK: 字体
func CommonFont12() -> UIFont {
    return UIFont.init(name: "HelveticaNeue", size: 12)!
}

func CommonFont16() -> UIFont {
    
    if SCREEN_WIDTH <= 320 {
        return UIFont.init(name: "HelveticaNeue", size: 14)!
    }
    return UIFont.init(name: "HelveticaNeue", size: 16)!
}

func CommonFont14() -> UIFont {
    
    if SCREEN_WIDTH <= 320 {
        return UIFont.init(name: "HelveticaNeue", size: 12)!
    }
    return UIFont.init(name: "HelveticaNeue", size: 14)!
}


//MARK: 颜色
func CommonSellColor() -> UIColor {
    return RGBCOLOR(r: 0x19, 0x7F, 0xBF)
}

func CommonBuyColor() -> UIColor {
    return RGBCOLOR(r: 0xF7, 0x44, 0x44)
}

func CommonDropColor() -> UIColor {
    return RGBCOLOR(r: 0x19, 0x7F, 0xBF)
}

func CommonRiseColor() -> UIColor {
    return RGBCOLOR(r: 0xF7, 0x44, 0x44)
}



//MARK: TableView

func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

func CommonBackgroundColor() -> UIColor {
    return RGBCOLOR(r: 238, 238, 238)
}

func CommonNavBarColor() -> UIColor {
    return RGBCOLOR(r: 32, 170, 216)
}

func CommonSeparatorLineColor() -> UIColor {
    return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
}

