//
//  SingalService.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import SwiftR

class SingalRService: NSObject {
    
    var signalR: SignalR?
    let signalRHub = SingalRHub()
    static let instance = SingalRService()
    
    class func getInstance() -> SingalRService {
        return instance
    }
    
    override init() {
        super.init()
        self.initSignalR()
        self.signalRStatus()
        self.signalRCallBack()
    }
    
    //MARK: init SignalR
    private func initSignalR() {
        signalR = SignalR(ProjectConfig.getInstance().SignalRServerUrl!)
        signalR?.useWKWebView = true
        signalR?.signalRVersion = .v2_2_1
        signalRHub.hubProxy = signalR?.createHubProxy("MiningHub")
        signalR?.addHub(signalRHub.hubProxy!)
        signalR?.start()
    }
    
    //MARK: SignalR Status
    private func signalRStatus() {
        
        signalR?.error = { error in
            print("CSC ---Error: \(String(describing: error))")
            if let source = error?["source"] as? String, source == "TimeoutException" {
                print("Connection timed out. Restarting...")
            }
        }
        
        signalR?.starting = {
            print("SR ---starting")
        }
        
        signalR?.connected = {
            print("SR ---connected")
//            self.signalRHub.RequestWokerList(poolName: "f2pool")
            self.signalRHub.RequestWokerList(poolName: "ethermine")
        }
        
        signalR?.disconnected = {
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
    
    //MARK: SignalR CallBack
    private func signalRCallBack() {
        
    }
    
}
