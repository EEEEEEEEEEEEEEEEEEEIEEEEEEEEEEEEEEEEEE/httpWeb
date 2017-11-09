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
    public func RequestLoginAuth(userID: String, userPass: String, callBack: ( (_ resultValue: Any?, _ error: Any?)->() )? = nil) {
        
        callBack!("test", "123")
        
        do {
            guard let hubProxy = hubProxy else {
                return
            }
            
            try hubProxy.invoke("RequestLoginAuth", arguments: [userID, userPass]){ (result, error) in
                
                guard let loginResultValue = Mapper<LoginResponseModel>().map(JSONObject: result) else {
                    
                    print("Hub === 登陆无返回值")
                    SingalRService.getInstance().loginStatus.value = EnumResult.failed
                    return
                }
                
                if (loginResultValue.UserName?.characters.count)! > 1 {
                    SingalRService.getInstance().loginStatus.value = EnumResult.success
                } else {
                    SingalRService.getInstance().loginStatus.value = EnumResult.failed
                }
                SingalRService.getInstance().loginResult.value = loginResultValue
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
            
            // RequestWorkerGroupInfo  RequestWorkerGroupList
            try hubProxy.invoke("RequestWorkerGroupInfo", arguments: []){ (result, error) in
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
            let jsonString = Mapper<WorkerInfo>().toJSONArray(workList)
            try hubProxy?.invoke("RequestChangeWorkers", arguments: [jsonString, password]) { (result, error) in
                guard let resultInfo = Mapper<ResultInfo>().map(JSONObject: result) else {
                    let resultError = ResultInfo()
                    resultError.resultIdValue = 99
                    resultError.Message = "未响应"
                    SingalRService.getInstance().requestChangeWokersResult.value = resultError
                    return
                }
                
                SingalRService.getInstance().requestChangeWokersResult.value = resultInfo
            }
        } catch  {
            print("error -- SingalRHub -- RequestChangeWokers")
        }
    }
}









