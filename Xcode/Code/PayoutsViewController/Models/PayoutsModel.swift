//
//  PayoutsModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/12.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class PayoutsModel: Mappable {
    var start: Int?
    var end: Int?
    var amount: Int?
    var txHash: String?
    var paidOn: Int?
    
    var dateTime: String? {
        get{
            let date = NSDate(timeIntervalSince1970: TimeInterval(NSInteger(paidOn!)))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "yyy-MM-dd hh:mm a"
            return dayTimePeriodFormatter.string(from: date as Date)
        }
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        start    <- map["start"]
        end      <- map["end"]
        amount   <- map["amount"]
        txHash   <- map["txHash"]
        paidOn   <- map["paidOn"]
    }
}


/*
{
    "status":"OK",
    "data":[
    {
    "start":4263620,
    "end":4264213,
    "amount":1003531982915411300,
    "txHash":"0x513b91ed34d8fa0faab967ff4573bcab0c4e45d85f39d0c3a73a4542b244a56d",
    "paidOn":1505180023
    },
 */

