//
//  WorkerInfo.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//  首字母大写

import UIKit
import ObjectMapper

class WorkerInfo: NSObject, Mappable {
    
    var MiningPool : String? {
        didSet{
            MiningPool = MiningPool?.capitalized
        }
    }
    var WorkerGroup: String? {
        didSet{
            WorkerGroup = WorkerGroup?.capitalized
        }
    }
    var WorkerId   : String? {
        didSet{
            WorkerId = WorkerId?.uppercased()
        }
    }
    var CoinType   : String?
    
    /* 1: True 0: false 服务写的是反过来了 */
    var UserFlag   : Bool? {
        willSet{
        }
    }
    
    /* 1：添加，2：删除 */
    var ActionFlag : Int?
    
    
    override init() {
        super.init()
        
        /* 这里初始化的意义在于不让存储时崩溃 */
//        self.MiningPool  = " "
//        self.WorkerGroup = " "
//        self.WorkerId    = " "
//        self.CoinType    = " "
//        self.UserFlag    = false
//        self.ActionFlag  = 1
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        MiningPool   <- map["MiningPool"]
        WorkerGroup  <- map["WorkerGroup"]
        WorkerId     <- map["WorkerID"]
        CoinType     <- map["CoinType"]
        UserFlag     <- map["UserFlag"]
        ActionFlag   <- map["ActionFlag"]
    }
}
