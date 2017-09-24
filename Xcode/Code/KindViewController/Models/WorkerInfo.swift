//
//  WorkerInfo.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class WorkerInfo: NSObject {
    
    var MiningPool: String?
    
    // MiningPool User API
    var ApiKey: String?
    
    var CoinType: String?
    var WorkerId: String?
    
    /// User Flag(Yes:true, No:false)
    var UserFollower: Bool?
    
    /// DATA Flag (1 : ADD, 2 : DEL)
    var ActionFlag: Bool?
}
