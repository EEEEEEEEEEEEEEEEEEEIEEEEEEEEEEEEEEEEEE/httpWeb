//
//  SeriveCenter.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/25.
//  Copyright © 2017年 Simon. All rights reserved.
//  相当于选择器

import UIKit
import RxCocoa
import RxSwift
import Dollar
import SwiftR

class SeriveCenter: NSObject {
    
    let singalR = SingalRService.getInstance()
    static let instance = SeriveCenter()
    class func getInstance() -> SeriveCenter {
        return instance
    }
    let disposeBag = DisposeBag()
    
    
    /// input
    // 这个不行，后面删除
    var poolRxIn     = Variable<EnumPool>(.Ethermine)
    
    var poolSelectIndexRxIn  = Variable<Int>(0)
    var groupSelectIndexRxIn = Variable<Int>(0)
    
    
    
    /// ouput
    
    // 服务器 本地 Data (包含各Pool)
    var serivceArrayRx        = Variable<[WorkerInfo]>([WorkerInfo]())
    var localAllArrayRxOut    = Variable<[WorkerInfo]>([WorkerInfo]())
    var localSelectArrayRxOut = Variable<[WorkerInfo]>([WorkerInfo]())
    
    // 当前的Worker和Payout，这个根据一二级选择
    var currentWorkerArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
    var currentPayoutArrayRxOut  = Variable<[PayoutsModel]>([PayoutsModel]())
    
    // Payout Data
    var payoutArrayRxOut      = Variable<[PayoutsModel]>([PayoutsModel]())
    
    // Worker Data
    var workerArrayRxOut = Variable<[WorkerModel]>([WorkerModel]()) //除OFF都包含
    var okArrayRxOut     = Variable<[WorkerModel]>([WorkerModel]())
    var offArrayRxOut    = Variable<[WorkerModel]>([WorkerModel]())
    var noRepArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
    var lowHRArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
    
    var okNumberRxOut    = Variable<Int>(0)
    var offNumberRxOut   = Variable<Int>(0)
    var noRepNumberRxOut = Variable<Int>(0)
    var lowHRNumberRxOut = Variable<Int>(0)
    
    
    // 一二级选择列表数据 (前者用于显示，后者用于存储)
    var userGroupArrayRxOut       = Variable<[String]>([String]())
    var userGroupArrayInfoRxOut   = Variable<[LoginWorkerGroupInfo]>([LoginWorkerGroupInfo]())
    
    var miningPoolArrayRxOut      = Variable<[String]>([String]())
    var miningPoolArrayInfoRxOut  = Variable<[LoginWorkerGroupInfo]>([LoginWorkerGroupInfo]())
    
    var workerGroupArrayRxOut     = Variable<[String]>([String]())
    var workerGroupArrayInfoRxOut = Variable<LoginWorkerGroupInfo>(LoginWorkerGroupInfo())
    
    
    override init() {
        super.init()
        _ = SingalRService.getInstance()
        self.initData()
//        self.initService()
        self.initSelectPoolAndGroup()
        self.initGetSignalRData()
    }
}


extension SeriveCenter {
    
    public func initData() {
        
        // 得到 localSelectArrayRxOut 
        singalR.serivceWorkerInfoArrayRx.asObservable().subscribe(onNext: { (value) in
            self.serivceArrayRx.value        = value
            self.localAllArrayRxOut.value    = value
            self.localSelectArrayRxOut.value = value
        }).addDisposableTo(disposeBag)
        
        
        // 得到 currentWorkerArrayRxOut 对pool group 监控转换
        Observable.combineLatest(workerGroupArrayInfoRxOut.asObservable(),
                                 EthermineService.getInstance().workerArrayRxOut.asObservable(),
                                 F2poolService.getInstance().workerArrayRxOut.asObservable())
            .subscribe(onNext: { (select, EtherWorkerArray, F2poolWorkerArray) in
                
                if select.MiningPool == nil { return }
                
                switch select.MiningPool! {
                case EnumPool.Ethermine.description:
                    self.currentWorkerArrayRxOut.value = EtherWorkerArray
                case EnumPool.F2pool.description:
                    self.currentWorkerArrayRxOut.value = F2poolWorkerArray
                default:
                    print("其它")
                }
            }).addDisposableTo(disposeBag)
        
        
        // 得到 currentPayoutArrayRxOut
        Observable.combineLatest(workerGroupArrayInfoRxOut.asObservable(),
                                 EthermineService.getInstance().payoutArrayRxOut.asObservable(),
                                 F2poolService.getInstance().payoutArrayRxOut.asObservable())
            .subscribe(onNext: { (select, EtherPaoutArray, F2poolPayouArray) in
                
                if select.MiningPool == nil { return }
                
                switch select.MiningPool! {
                case EnumPool.Ethermine.description:
                    self.currentPayoutArrayRxOut.value = EtherPaoutArray
                case EnumPool.F2pool.description:
                    self.currentPayoutArrayRxOut.value = F2poolPayouArray
                default:
                    print("其它")
                }
            }).addDisposableTo(disposeBag)
        
        
        // 以后还要观察阀值
        Observable.combineLatest(localSelectArrayRxOut.asObservable(),
                                 currentWorkerArrayRxOut.asObservable())
            .subscribe(onNext: { (localSelectArray, currentWorkerArray) in
                
                let currentWorkerIdArray: [String] = currentWorkerArray.map({ $0.worker! })
                
                var newWorkerArray      = [WorkerModel]()
                var newOkWorkerArray    = [WorkerModel]()
                var newOffWorkerArray   = [WorkerModel]()
                var newNoRepWorkerArray = [WorkerModel]()
                var newLowHRWorkerArray = [WorkerModel]()
                
                localSelectArray.forEach { (element) in
                    if $.contains(currentWorkerIdArray, value: element.WorkerId!) {
                        let newWorkerModel: WorkerModel = currentWorkerArray[currentWorkerIdArray.index(of: element.WorkerId!)!]
                        
                        if newWorkerModel.repHR! >= 150000000.0 {
                            newWorkerModel.workerStatus = EnumWorkerStatus.OK
                            newOkWorkerArray.append(newWorkerModel)
                        } else if newWorkerModel.repHR! > 0.0 {
                            newWorkerModel.workerStatus = EnumWorkerStatus.LowHR
                            newLowHRWorkerArray.append(newWorkerModel)
                        } else {
                            newWorkerModel.workerStatus = EnumWorkerStatus.NoRep
                            newNoRepWorkerArray.append(newWorkerModel)
                        }
                        newWorkerArray.append(newWorkerModel)
                    } else {
                        let newOffModel = WorkerModel()
                        newOffModel.workerStatus = EnumWorkerStatus.OFF
                        newOffModel.worker = element.WorkerId
                        newOffWorkerArray.append(newOffModel)
                    }
                }
                self.workerArrayRxOut.value = newWorkerArray
                self.okArrayRxOut.value     = newOkWorkerArray
                self.offArrayRxOut.value    = newOffWorkerArray
                self.noRepArrayRxOut.value  = newNoRepWorkerArray
                self.lowHRArrayRxOut.value  = newLowHRWorkerArray
                
                self.okNumberRxOut.value    = newOkWorkerArray.count
                self.offNumberRxOut.value   = newOffWorkerArray.count
                self.noRepNumberRxOut.value = newNoRepWorkerArray.count
                self.lowHRNumberRxOut.value = newLowHRWorkerArray.count
                
            }).addDisposableTo(disposeBag)
        
        
        /*
        // WorkerInfo 过滤条件: Pool选择
        let singalRSerivceHub = SingalRService.getInstance().signalRHub
        Observable.combineLatest(poolRxIn.asObservable(),
                                     singalRSerivceHub.ethermineWorkerInfoArrayRx.asObservable(),
                                     singalRSerivceHub.f2poolWorkerInfoArrayRx.asObservable())
            .subscribe(onNext: { (poolSelect, ethermineWorkerInfoArray, f2poolWorkerInfoArray) in
                switch poolSelect {
                case EnumPool.Ethermine:
                    self.serivceArrayRx.value = ethermineWorkerInfoArray
                    self.localAllArrayRxOut.value = ethermineWorkerInfoArray
                    self.localSelectArrayRxOut.value = ethermineWorkerInfoArray
                case EnumPool.F2pool:
                    self.serivceArrayRx.value = f2poolWorkerInfoArray
                    self.localAllArrayRxOut.value = ethermineWorkerInfoArray
                    self.localSelectArrayRxOut.value = ethermineWorkerInfoArray
                }
            }).addDisposableTo(disposeBag)
        
        
        // Payout 过滤条件: Pool选择
        Observable.combineLatest(poolRxIn.asObservable(),
                                     EthermineService.getInstance().payoutArrayRxOut.asObservable(),
                                     F2poolService.getInstance().payoutArrayRxOut.asObservable())
            .subscribe(onNext: { (poolSelect, etherminePayoutArray, f2poolPayoutArray) in
                switch poolSelect {
                case EnumPool.Ethermine:
                    self.payoutArrayRxOut.value = etherminePayoutArray
                case EnumPool.F2pool:
                    self.payoutArrayRxOut.value = f2poolPayoutArray
                }
            }).addDisposableTo(disposeBag)
        
        
        
        
        // WorkerModel 过滤条件: 网站选择、本地数据打勾的
        Observable.combineLatest(poolRxIn.asObservable(),
                                 localSelectArrayRxOut.asObservable(),
                                 EthermineService.getInstance().workerArrayRxOut.asObservable(),
                                 F2poolService.getInstance().workerArrayRxOut.asObservable())
            .subscribe(onNext: { (poolSelect, localSelectArray, ethermineWorkerArray, f2poolWorkerArray) in
                    var sourceArray = [WorkerModel]()
                    switch poolSelect {
                    case EnumPool.Ethermine:
                        sourceArray = ethermineWorkerArray
                    case EnumPool.F2pool:
                        sourceArray = f2poolWorkerArray
                    }
                    let sourceWorkerIdArray: [String] = sourceArray.map({ $0.worker! })
                    
                    var newWorkerArray      = [WorkerModel]()
                    var newOkWorkerArray    = [WorkerModel]()
                    var newOffWorkerArray   = [WorkerModel]()
                    var newNoRepWorkerArray = [WorkerModel]()
                    var newLowHRWorkerArray = [WorkerModel]()
                    
                    
                    localSelectArray.forEach { (element) in
                        if $.contains(sourceWorkerIdArray, value: element.WorkerId!) {
                            let newWorkerModel: WorkerModel = sourceArray[sourceWorkerIdArray.index(of: element.WorkerId!)!]
                            
                            if newWorkerModel.repHR! >= 150000000.0 {
                                newWorkerModel.workerStatus = EnumWorkerStatus.OK
                                newOkWorkerArray.append(newWorkerModel)
                            } else if newWorkerModel.repHR! > 0.0 {
                                newWorkerModel.workerStatus = EnumWorkerStatus.LowHR
                                newLowHRWorkerArray.append(newWorkerModel)
                            } else {
                                newWorkerModel.workerStatus = EnumWorkerStatus.NoRep
                                newNoRepWorkerArray.append(newWorkerModel)
                            }
                            newWorkerArray.append(newWorkerModel)
                        } else {
                            let newOffModel = WorkerModel()
                            newOffModel.workerStatus = EnumWorkerStatus.OFF
                            newOffModel.worker = element.WorkerId
                            newOffWorkerArray.append(newOffModel)
                        }
                    }
                    
                    self.workerArrayRxOut.value = newWorkerArray
                    self.okArrayRxOut.value     = newOkWorkerArray
                    self.offArrayRxOut.value    = newOffWorkerArray
                    self.noRepArrayRxOut.value  = newNoRepWorkerArray
                    self.lowHRArrayRxOut.value  = newLowHRWorkerArray
                    
                    self.okNumberRxOut.value    = newOkWorkerArray.count
                    self.offNumberRxOut.value   = newOffWorkerArray.count
                    self.noRepNumberRxOut.value = newNoRepWorkerArray.count
                    self.lowHRNumberRxOut.value = newLowHRWorkerArray.count
            }).addDisposableTo(disposeBag)  */
    }
    
    public func initService() {
        
        SingalRService.getInstance().conntentStatus.asObservable().subscribe(onNext: { (status) in
            if status == State.connected {
//                SingalRService.getInstance().RequestWokerList(poolName: EnumPool.Ethermine)
            }
        }).addDisposableTo(disposeBag)
    }
}





/* F2pool */
extension SeriveCenter {
    
}

/* Ethermine */
extension SeriveCenter {
    
}


/* SingalR */
extension SeriveCenter {
    
    /* 登陆 */
    func login(_ username: String, password: String) -> Observable<EnumResult> {
        singalR.signalRHub.RequestLoginAuth(userID: username, userPass: password)
        return singalR.loginStatus.asObservable()
    }
    
    
    /* 选择矿池与组 */
    func initSelectPoolAndGroup() {
        
        // pool 变化时 group 默认为0
        poolSelectIndexRxIn.asObservable().subscribe(onNext: { (value) in self.groupSelectIndexRxIn.value = 0 })
            .addDisposableTo(disposeBag)
        
        // miningPoolArrayRxOut 来源
        singalR.workerGroupInfoListResult.asObservable().subscribe(onNext: { (poolGroupInfoArray) in
            
            var miningPoolArrayBuff     = [String]()
            poolGroupInfoArray.forEach { (element) in
                if !miningPoolArrayBuff.contains(element.MiningPool!) {
                    miningPoolArrayBuff.append(element.MiningPool!)
                }
            }
            self.miningPoolArrayRxOut.value     = miningPoolArrayBuff
        }).addDisposableTo(disposeBag)
        
        
        // workerGroupArrayRxOut, miningPoolArrayInfoRxOut 来源
        Observable.combineLatest(poolSelectIndexRxIn.asObservable(),
                                 miningPoolArrayRxOut.asObservable(),
                                 singalR.workerGroupInfoListResult.asObservable())
            .subscribe(onNext: { (poolIndex, poolArray, poolGroupInfoArray) in
                if poolIndex < poolArray.count {
                    
                    let selectPool = poolArray[poolIndex]
                    var workerGroupArrayBuff    = [String]()
                    var miningPoolArrayInfoBuff = [LoginWorkerGroupInfo]()
                    
                    poolGroupInfoArray.forEach { (element) in
                        if element.MiningPool == selectPool {
                            miningPoolArrayInfoBuff.append(element)
                            if !workerGroupArrayBuff.contains(element.WorkerGroup!) {
                                workerGroupArrayBuff.append(element.WorkerGroup!)
                            }
                        }
                    }
                    self.miningPoolArrayInfoRxOut.value = miningPoolArrayInfoBuff
                    self.workerGroupArrayRxOut.value    = workerGroupArrayBuff
                }
        }).addDisposableTo(disposeBag)
        
        
        // workerGroupArrayInfoRxOut 来源
        Observable.combineLatest(groupSelectIndexRxIn.asObservable(),
                                 workerGroupArrayRxOut.asObservable(),
                                 miningPoolArrayInfoRxOut.asObservable())
            .subscribe(onNext: { (groupIndex, groupArray, poolInfoArray) in
                
                if groupIndex < groupArray.count {
                    let selectGroup = groupArray[groupIndex]
                    var workreGroupArrayInfoBuff = LoginWorkerGroupInfo()
                    poolInfoArray.forEach { (element) in
                        if element.WorkerGroup == selectGroup {
                            workreGroupArrayInfoBuff = element
                        }
                    }
                    
                    if (workreGroupArrayInfoBuff.MiningPool == "") || (workreGroupArrayInfoBuff.WorkerGroup == "") {
                        return
                    }
                    if (workreGroupArrayInfoBuff.MiningPool == self.workerGroupArrayInfoRxOut.value.MiningPool) && (workreGroupArrayInfoBuff.WorkerGroup == self.workerGroupArrayInfoRxOut.value.WorkerGroup) {
                        return
                    }
                    
                    self.workerGroupArrayInfoRxOut.value = workreGroupArrayInfoBuff
                    print("\(workreGroupArrayInfoBuff)")
                }
        }).addDisposableTo(disposeBag)
    }
    
    /* 选择矿池与组后，对服务器数据请求, 以及对矿池网站的选择 */
    func initGetSignalRData() {
        workerGroupArrayInfoRxOut.asObservable().subscribe(onNext: { (select) in
            if (select.MiningPool == nil) || (select.WorkerGroup == nil) {
                return
            }
            // *** 这里带的参数要注意大小写
            self.singalR.signalRHub.RequestWokerList(poolName: select.MiningPool!, groupName: select.WorkerGroup!)
            
            if select.APIKey.isEmpty {
                return
            }
            
            switch select.MiningPool! {
            case EnumPool.Ethermine.description:
                EthermineService.getInstance().refreshData(account: select.WorkerGroup!, key: select.APIKey)
            case EnumPool.F2pool.description:
                F2poolService.getInstance().refreshData(account: select.WorkerGroup!, key: select.APIKey)
            default:
                print("其它")
            }
            
            
            
        }).addDisposableTo(disposeBag)
    }
    
    
    
    
    
    /*
    func validateUsername(_ username: String) -> Observable<EnumResult> {
        if username.characters.count >= 6 {
            return .just(.success(message: "用户名可用"))
        }
        else if username.characters.count == 0 {
            return .just(.empty)
        }
        return .just(.failed(message: "至少6个字符"))
    }
    
    func validatePhone(_ phone: String) -> Observable<EnumResult> {
        if phone.isPhoneNumber {
            return .just(.success(message: "号码有效"))
        }
        else if phone.characters.count == 0 {
            return .just(.empty)
        }
        return .just(.failed(message: "号码无效"))
    } */
}














