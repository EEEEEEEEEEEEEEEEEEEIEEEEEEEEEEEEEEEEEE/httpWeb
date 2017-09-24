//
//  SingalHub.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import SwiftR

class SingalRHub: NSObject {
    var hubProxy: Hub?
    
    // WorkerId Management [동기화 / Synchronization / 同步]  return: List<WorkerInfo>
    public func RequestWokerList(poolName: String) {
        do {
            try hubProxy?.invoke("RequestWorkerList", arguments: [poolName]) { (result, error) in
                if let e = error {
                    print("error: \(e)")
                } else {
                    print("success")
                    if let r = result {
//                        print("\(r)")
                    }
                }
            }
        } catch {
            print("error -- SingalRHub -- RequestWokerList")
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
