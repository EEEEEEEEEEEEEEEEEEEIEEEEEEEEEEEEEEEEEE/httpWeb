//
//  WorkerModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/13.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class WorkerModel: Mappable {
    
    var worker: String?
    var time: Int?
    var lastSeen:Int?
    var repHR: Float?
    var curHR: Int?
    var avgHR: Int?
    var validShares: Int?
    var invalidShares: Int?
    var staleShares: Int?
    
    var dateTime: String? {
        get{
            let date = NSDate(timeIntervalSince1970: TimeInterval(NSInteger(time!)))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "yyy-MM-dd hh:mm a"
            return dayTimePeriodFormatter.string(from: date as Date)
        }
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        worker        <- map["worker"]
        time          <- map["time"]
        lastSeen      <- map["lastSeen"]
        repHR         <- map["reportedHashrate"]
        curHR         <- map["currentHashrate"]
        avgHR         <- map["averageHashrate"]
        validShares   <- map["validShares"]
        invalidShares <- map["invalidShares"]
        staleShares   <- map["staleShares"]
    }
    
}



/*
{
    "status":"OK",
    "data":[
    {
    "worker":"a001",
    "time":1505270400,
    "lastSeen":1505270391,
    "reportedHashrate":164818029,
    "currentHashrate":172888888.8888889,
    "validShares":153,
    "invalidShares":0,
    "staleShares":4,
    "averageHashrate":238497685.18518516
    },
*/
