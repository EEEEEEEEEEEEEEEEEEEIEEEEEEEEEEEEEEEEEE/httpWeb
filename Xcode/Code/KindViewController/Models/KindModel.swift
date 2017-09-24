//
//  KindModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/18.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class KindModel: Mappable {
    
    var workerId: String?
    var coinType: String?
    
    required init?(map: Map) {
        coinType = "ETH"
    }
    
    func mapping(map: Map) {
        workerId     <- map["worker"]
    }
}
