//
//  SingalHub.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import SwiftR
import ObjectMapper
import RxCocoa
import RxSwift

class SingalRHub: NSObject {
    var hubProxy: Hub?
    
    // 这样做会不可，因为以后可能有很多池，很多组
    var ethermineWorkerInfoArrayRx = Variable<[WorkerInfo]>([WorkerInfo]())
    var f2poolWorkerInfoArrayRx    = Variable<[WorkerInfo]>([WorkerInfo]())
    
    
    
    /*
     public CustomerInfo RequestLoginAuth(string userID, string userPass)
     */
    public func RequestLoginAuth(userID: String, userPass: String) {
        do {
            guard let hubProxy = hubProxy else {
                return
            }
            
            try hubProxy.invoke("RequestLoginAuth", arguments: [userID, userPass]){ (result, error) in
                if let loginResultValue = Mapper<LoginResponseModel>().map(JSONObject: result) {
                    SingalRService.getInstance().loginStatus.value = EnumResult.success
                    SingalRService.getInstance().loginResult = loginResultValue
                } else {
                    print("Hub === 登陆无返回值")
                }
            }
        } catch {
            print("Login error=\(error)")
        }
    }
    
    
    
    public func RequestWorkerGroupList() {
        do {
            guard let hubProxy = hubProxy else {
                return
            }
            
            try hubProxy.invoke("RequestWorkerGroupList", arguments: []){ (result, error) in
                if let buffList = Mapper<LoginWorkerGroupInfo>().mapArray(JSONObject: result) {
                    SingalRService.getInstance().workerGroupInfoListResult.value = buffList
                } else {
                    print("Hub === 工作组无数据")
                }
            }
            
        } catch {
            print("Login error=\(error)")
        }
    }
    
    
    
    public func RequestWokerList(poolName:String, groupName: String)
    {
        do
        {
            guard let hubProxy = hubProxy else {
                return
            }
            
            try hubProxy.invoke("RequestWorkerList", arguments: [poolName, groupName]){ (result, error) in
                
                if let workerInfoArray = Mapper<WorkerInfo>().mapArray(JSONObject: result) {
                    SingalRService.getInstance().serivceWorkerInfoArrayRx.value = workerInfoArray
                } else {
                    print("Hub === 你选择的无数据")
                }
            }
            
        } catch {
            print("Login error=\(error)")
        }
    }
    
    
    // WorkerId Set [(등록 및 삭제) / (Insert, Delete) / (注册, 删除)]  return: ResultInfo
    public func RequestChangeWokers(workList: [WorkerInfo], password: String) {
        do {
            try hubProxy?.invoke("RequestChangeWokers", arguments: [workList, password]) { (result, error) in
                if let e = error {
                    print("error: \(e)")
                } else {
                    print("Success")
                    if let r = result {
                        print("\(r)")
                    }
                }
            }
        } catch  {
            print("error -- SingalRHub -- RequestChangeWokers")
        }
    }
}
