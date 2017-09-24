//
//  PoolModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/18.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class PoolModel: Mappable {
    
    var poolName: String?
    var workerId: String?
    var coinType: String?
    var selectEnable: Bool?
    var status: Bool?
    
    required init?(map: Map) {
        poolName = "F2Pool"
        coinType = "ETH"
        selectEnable = false
        status = true
    }
    
    func mapping(map: Map) {
        workerId     <- map["worker"]
    }
}
