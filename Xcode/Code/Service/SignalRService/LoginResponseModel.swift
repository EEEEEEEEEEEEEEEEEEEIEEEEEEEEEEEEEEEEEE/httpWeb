//
//  LoginResponseModel.swift
//  MInePool
//
//  Created by Hanxun on 2017/9/28.
//  Copyright © 2017年 Hxnidc. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginResponseModel: NSObject, Mappable {
    
    var UserGroup    : String = ""
    var UserID       : String = ""
    var UserPassword : String = ""
    var UserName     : String = ""
    var UserAuth     : Int    = 0
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        UserGroup    <- map["UserGroup"]
        UserID       <- map["UserID"]
        UserPassword <- map["UserPassword"]
        UserName     <- map["UserName"]
        UserAuth     <- map["UserAuth"]
    }
}


/*
 public class CustomerInfo
 {
 /// <summary>사용자 그룹</summary>
 public string UserGroup { get; set; }
 
 /// <summary>사용자 ID</summary>
 public string UserID { get; set; }
 
 /// <summary>사용자 비밀번호</summary>
 public string UserPassword { get; set; }
 
 /// <summary>사용자명</summary>
 public string UserName { get; set; }
 
 /// <summary>权威(0:error, 1:经理, 2:用户)</summary>
 public int UserAuth { get; set; }
 }
 */
