//
//  SingalService.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import SwiftR
import RxCocoa
import RxSwift
import Dollar

class SingalRService: NSObject {
    
    var signalR: SignalR?
    let signalRHub = SingalRHub()
    
    let disposeBag = DisposeBag()
    
    var conntentStatus = Variable<State>(.disconnected)
    var loginStatus    = Variable<EnumResult>(EnumResult.failed)
    var loginResult    = LoginResponseModel()
    var workerGroupInfoListResult = Variable<[LoginWorkerGroupInfo]>([LoginWorkerGroupInfo]())
    var serivceWorkerInfoArrayRx  = Variable<[WorkerInfo]>([WorkerInfo]())
    
    
    
    static let instance = SingalRService()
    class func getInstance() -> SingalRService {
        return instance
    }
    
    override init() {
        super.init()
        self.initSignalR()
        self.initData()
        self.signalRStatus()
    }
}


extension SingalRService {
    
    //MARK: init SignalR
    fileprivate func initSignalR() {
        signalR = SignalR(ProjectConfig.getInstance().SignalRServerUrl!)
        signalR?.useWKWebView = true
        signalR?.signalRVersion = .v2_2_1
        signalRHub.hubProxy = signalR?.createHubProxy("MiningHub")
        signalR?.addHub(signalRHub.hubProxy!)
        signalR?.start()
    }
    
    //MARK: SignalR Status
    fileprivate func signalRStatus() {
        
        signalR?.error = { error in
            print("CSC ---Error: \(String(describing: error))")
            if let source = error?["source"] as? String, source == "TimeoutException" {
                print("Connection timed out. Restarting...")
                self.conntentStatus.value = State.disconnected
            }
        }
        
        signalR?.starting = {
            print("SR ---starting")
        }
        
        signalR?.connected = {
            print("SR ---connected")
            self.conntentStatus.value = State.connected
            //            self.signalRHub.RequestWokerList(poolName: EnumPool.F2pool)
            //            self.signalRHub.RequestWokerList(poolName: "ethermine")
        }
        
        signalR?.disconnected = {
            self.conntentStatus.value = State.disconnected
            print("SR ---disconnected")
        }
        
        signalR?.connectionSlow = {
            print("SR ---connectionSlow")
        }
        
        signalR?.connectionFailed = {
            print("SR ---connectionFailed")
        }
        
        signalR?.reconnecting = {
            print("SR ---reconnecting")
        }
        
        signalR?.reconnected = {
            print("SR ---reconnected")
        }
    }
    
    //MAKR: 初始化数据
    fileprivate func initData() {
        loginStatus.asObservable().distinctUntilChanged{
            $0.rawValue == $1.rawValue
        }.subscribe(onNext: { (value) in
            if value == EnumResult.success {
                self.signalRHub.RequestWorkerGroupList()
            }
        }).addDisposableTo(disposeBag)
    }
}




