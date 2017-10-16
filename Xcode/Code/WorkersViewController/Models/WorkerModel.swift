//
//  WorkerModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/13.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class WorkerModel: NSObject, Mappable {
    
    var worker: String? {
        didSet{
            worker = worker?.uppercased()
        }
    }
    var time: Int?
    var lastSeen:Int?
    var repHR: Float?
    var curHR: Int?
    var avgHR: Int?
    var validShares: Int?
    var invalidShares: Int?
    var staleShares: Int?
    
    var currency: EnumCurrency?
    var workerStatus: EnumWorkerStatus?
    var dateTime: String? {
        get{
            return time == nil ? "Null" : DateTime().timeStampToInteger(NSInteger(time!))
        }
    }
    
    // 加这个，为了让初始化不出错
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        self.currency = EnumCurrency.ETH
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
        
        
        /*f2pool*/
        worker        <- map["worker_name"]
        time          <- map["last_share"]
        repHR         <- map["hashrate"]
    }
    
}


/* f2pool
 
 var worker_name                              : String =  ""
 var status                                   : Double =  0
 var last_share                               : Double =  0
 var hashrate                                 : Double =  0
 var currency                                 : String =  ""
 
 ▿ 86 : 13 elements
 ▿ 0 : 2 elements
 - key : shares_accepted
 - value : 0
 ▿ 1 : 2 elements
 - key : sort_key
 - value : 88
 ▿ 2 : 2 elements
 - key : hashrate
 - value : 431882823
 ▿ 3 : 2 elements
 - key : stale_shares_rejected
 - value : 0
 ▿ 4 : 2 elements
 - key : last_share
 - value : 1507721876
 ▿ 5 : 2 elements
 - key : group
 - value :
 ▿ 6 : 2 elements
 - key : group_id
 - value : 0
 ▿ 7 : 2 elements
 - key : stalerate
 - value : 0.002915079141841614
 ▿ 8 : 2 elements
 - key : currency
 - value : LTC
 ▿ 9 : 2 elements
 - key : hashrate_last_day
 - value : 486004878.6014815
 ▿ 10 : 2 elements
 - key : sort_key_2
 - value : 86
 ▿ 11 : 2 elements
 - key : status
 - value : 0
 ▿ 12 : 2 elements
 - key : worker_name
 - value : atm.089
*/
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







