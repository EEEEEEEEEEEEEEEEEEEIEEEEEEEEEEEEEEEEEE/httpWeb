//
//  EthermineService.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/25.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper
import SwiftyJSON

class EthermineService: NSObject {
    
    
    static let instance = EthermineService()
    class func getInstance() -> EthermineService {
        return instance
    }
    
    
    let disposeBag = DisposeBag()
    var workerArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
    var payoutArrayRxOut  = Variable<[PayoutsModel]>([PayoutsModel]())
    
    
    override init() {
        super.init()
    }
    
    func refreshData(account: String, key: String) {
        
        if account.isEmpty || key.isEmpty {
            return
        }
        
        Provider.request(.workers(miner: key)).mapJSON().asObservable().subscribe(onNext: { (value) in
            
            let jsonDic = value as! [String: Any]
            let jsonArray = jsonDic["data"]
            let objects = Mapper<WorkerModel>().mapArray(JSONObject: jsonArray)
            self.workerArrayRxOut.value = objects!
            
        }).addDisposableTo(disposeBag)
        
        
        Provider.request(.payouts(miner: key)).mapJSON().asObservable().subscribe(onNext: { (value) in
            let jsonDic = value as! [String: Any]
            let jsonArray = jsonDic["data"]
            let objects = Mapper<PayoutsModel>().mapArray(JSONObject: jsonArray)
            self.payoutArrayRxOut.value = objects!
        }).addDisposableTo(disposeBag)
    }
}
