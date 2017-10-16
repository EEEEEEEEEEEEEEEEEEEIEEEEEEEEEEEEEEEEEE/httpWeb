//
//  F2poolAPI.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/25.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import ObjectMapper

class F2poolAPI: NSObject {

    var workerArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
    var payoutArrayRxOut  = Variable<[PayoutsModel]>([PayoutsModel]())
    
    /// 账号信息
//    let userKey = "9587ce626fc78670816aeda91d531a36"
//    let account = "atm"
    var userKey = ""
    var account = ""
    
    let baseLognUrl = "https://www.f2pool.com/mining-user/"
    let baseWorkerUrl = "https://www.f2pool.com/user/worker?action=load&account="
    let basePayoutUrl = "https://www.f2pool.com/user/history?action=load_payout_history&account="
    
    var f2poolLoginStatus = Variable<Bool>(false)
    
    /// 从登陆获取Cookie
    public func loginF2pool() {
        let loginString = baseLognUrl + userKey
        Alamofire.request(loginString).responseJSON { response in
            
            let statusCode = response.response?.statusCode
//            print("\(statusCode)")
            if statusCode == 200 {
                self.f2poolLoginStatus.value = true
            }
            
            /// let cokk = HTTPCookieStorage.shared.cookies
        }
    }
    
    public func getF2poolWorkerList() {
        let workerUrl = self.baseWorkerUrl + self.account
        let workerURL = URL(string: workerUrl)
        var request = URLRequest(url: workerURL!)
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        Alamofire.request(request).responseJSON { (result) in
            
            let statusCode = result.response?.statusCode
            if statusCode == 200 {
                
                let jsonDic   = result.result.value as! [String : Any]
                let jsonDicBuff = jsonDic["data"] as! [String : Any]
                let jsonArray = jsonDicBuff["workers"]
                if let objects = Mapper<WorkerModel>().mapArray(JSONObject: jsonArray) {
                    self.workerArrayRxOut.value = objects
                }
                
            } else {
                print("F2pool 掉线，请重新登陆")
            }
        }
    }
    
    public func getF2poolpayoutList() {
        let payoutUrl = self.basePayoutUrl + self.account
        let payoutURL = URL(string: payoutUrl)
        var payoutRequest = URLRequest(url: payoutURL!)
        payoutRequest.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        Alamofire.request(payoutRequest).responseJSON { (result) in
            
            let statusCode = result.response?.statusCode
            if statusCode == 200 {
                
                let jsonDic   = result.result.value as! [String : Any]
                let jsonArray = jsonDic["data"]
                if let objects = Mapper<PayoutsModel>().mapArray(JSONObject: jsonArray) {
                    self.payoutArrayRxOut.value = objects
                }
                
            } else {
                print("F2pool 掉线，请重新登陆")
            }
        }
    }
}





