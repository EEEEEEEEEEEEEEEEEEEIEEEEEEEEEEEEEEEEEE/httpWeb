//
//  LoginWorkerGroupInfo.swift
//  MInePool
//
//  Created by Hanxun on 2017/9/29.
//  Copyright © 2017年 Hxnidc. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginWorkerGroupInfo: NSObject, Mappable {

    /* 用户组 */
    var UserGroup:    String? {
        didSet{
            UserGroup = UserGroup?.capitalized
        }
    }
    
    /* 网站一级 */
    var MiningPool:   String? {
        didSet{
            self.MiningPool = MiningPool?.capitalized
        }
    }
    
    /* 币种二级 */
    var WorkerGroup:  String? {
        didSet{
            self.WorkerGroup = WorkerGroup?.capitalized
        }
    }
    
    /* 拼接的URL */
    var APIKey:       String = ""
    
    /* 币种类型 */
    var CoinType:     String = ""
    
    var UserFlag:     Bool   = false
    var ActionFlag:   Int    = 0
    
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        UserGroup   <- map["UserGroup"]
        MiningPool  <- map["MiningPool"]
        WorkerGroup <- map["WorkerGroup"]
        APIKey      <- map["APIKey"]
        CoinType    <- map["CoinType"]
        UserFlag    <- map["UserFlag"]
        ActionFlag  <- map["ActionFlag"]
    }
}


/*
 public class WorkerGroupInfo
 {
 /// <summary>User Group</summary>
 public string UserGroup { get; set; }
 
 /// <summary>Mining Pool</summary>
 public string MiningPool { get; set; }
 
 /// <summary>Worker Group</summary>
 public string WorkerGroup { get; set; }
 
 /// <summary>API Key</summary>
 public string APIKey { get; set; }
 
 /// <summary>Coin Type</summary>
 public string CoinType { get; set; }
 
 /// <summary>User Flag(0:True, other:False)</summary>
 public bool UserFlag { get; set; }
 
 /// <summary>Server API</summary>
 /// <remarks>1:Insert, 2:Delete</remarks>
 public int ActionFlag { get; set; }
 
 }
 
 */
