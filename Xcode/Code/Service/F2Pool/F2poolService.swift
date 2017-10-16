//
//  F2poolService.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/25.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class F2poolService: NSObject {
    
    static let instance = F2poolService()
    class func getInstance() -> F2poolService {
        return instance
    }
    
    let currentIDType = Variable<EnumF2pIDType>(EnumF2pIDType.atm)
    let f2poolApi     = F2poolAPI()
    let f2poolAtm2Api = F2poolAPI()
    let disposeBag = DisposeBag()
    
    // 这两个是 atm atm2 公用的值
    var workerArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
    var payoutArrayRxOut  = Variable<[PayoutsModel]>([PayoutsModel]())
    
    
    
    override init() {
        super.init()
        
        /* 登陆成功后请求一次 */
        
        f2poolApi.f2poolLoginStatus.asObservable().subscribe(onNext: { (status) in
            if status == true {
                self.f2poolApi.getF2poolWorkerList()
                self.f2poolApi.getF2poolpayoutList()
            }
        }).addDisposableTo(disposeBag)
        
        f2poolAtm2Api.f2poolLoginStatus.asObservable().subscribe(onNext: { (status) in
            if status == true {
                self.f2poolAtm2Api.getF2poolWorkerList()
                self.f2poolAtm2Api.getF2poolpayoutList()
            }
        }).addDisposableTo(disposeBag)
        
        
        /* 对 atm atm2值的选择 */
        
        Observable.combineLatest(currentIDType.asObservable(),
                                 f2poolApi.workerArrayRxOut.asObservable(),
                                 f2poolAtm2Api.workerArrayRxOut.asObservable())
            .subscribe(onNext: { (currentID, atmWorkerArray, atm2WorkerArray) in
                switch currentID {
                case EnumF2pIDType.atm:
                    self.workerArrayRxOut.value = atmWorkerArray
                case EnumF2pIDType.atm2:
                    self.workerArrayRxOut.value = atm2WorkerArray
                }
            }).addDisposableTo(disposeBag)
        
        Observable.combineLatest(currentIDType.asObservable(),
                                 f2poolApi.payoutArrayRxOut.asObservable(),
                                 f2poolAtm2Api.payoutArrayRxOut.asObservable())
            .subscribe(onNext: { (currentID, atmPayoutArray, atm2PayoutArray) in
                switch currentID {
                case EnumF2pIDType.atm:
                    self.payoutArrayRxOut.value = atmPayoutArray
                case EnumF2pIDType.atm2:
                    self.payoutArrayRxOut.value = atm2PayoutArray
                }
            }).addDisposableTo(disposeBag)
    }
    
    // 刷新
    func refreshData(account: String, key: String) {
        
        if account.isEmpty || key.isEmpty {
            return
        }
        
        let newBuffType: EnumF2pIDType = EnumF2pIDType(rawValue: account)!
        switch newBuffType {
        case EnumF2pIDType.atm:
            self.f2poolApi.account = account.lowercased()
            self.f2poolApi.userKey = key.lowercased()
            if self.f2poolApi.f2poolLoginStatus.value == true {
                self.f2poolApi.getF2poolWorkerList()
                self.f2poolApi.getF2poolpayoutList()
            } else {
                self.f2poolApi.loginF2pool()
            }
        case EnumF2pIDType.atm2:
            self.f2poolAtm2Api.account = account.lowercased()
            self.f2poolAtm2Api.userKey = key.lowercased()
            if self.f2poolAtm2Api.f2poolLoginStatus.value == true {
                self.f2poolAtm2Api.getF2poolWorkerList()
                self.f2poolAtm2Api.getF2poolpayoutList()
            } else {
                self.f2poolAtm2Api.loginF2pool()
            }
        }
        currentIDType.value = newBuffType
    }
    
}



enum EnumF2pIDType: String {
    case atm  = "Atm"
    case atm2 = "Atm2"
}















