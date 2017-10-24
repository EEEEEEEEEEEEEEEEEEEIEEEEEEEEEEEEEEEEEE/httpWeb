//
//  EditWorkerInfoViewModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/10/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditWorkerInfoViewModel: NSObject {

    let disposeBag = DisposeBag()
    
    // input
    var miningPool  = Variable<String>("")
    var workerGroup = Variable<String>("")
    var workerId    = Variable<String?>("test")
    var coinType    = Variable<String>("ETH")
    var userFlag    = Variable<Bool>(true)
    /* 1：添加，2：删除 */
    //var actionFlag = Variable<Int>(1)
    
    // output
    var requestChangeWokersResult = Variable<ResultInfo>(ResultInfo())
    
    override init() {
        super.init()
        SeriveCenter.getInstance().workerGroupArrayInfoRxOut.asObservable()
            .distinctUntilChanged().subscribe(onNext: { (currentPoolGroup) in
                self.miningPool.value  = currentPoolGroup.MiningPool!
                self.workerGroup.value = currentPoolGroup.WorkerGroup!
        }).addDisposableTo(disposeBag)
        
        SeriveCenter.getInstance().requestChangeWokersResult.asObservable()
            .subscribe(onNext: { (value) in
                self.requestChangeWokersResult.value = value
        }).addDisposableTo(disposeBag)
    }
    
    // 增加WorkerInfo
    public func saveDataHandle() {
        var editWorkerInfoArray = [WorkerInfo]()
        let editWorkerInfo = WorkerInfo()
        editWorkerInfo.MiningPool  = miningPool.value.lowercased()
        editWorkerInfo.WorkerGroup = workerGroup.value.lowercased()
        editWorkerInfo.WorkerId    = workerId.value?.lowercased()
        editWorkerInfo.CoinType    = coinType.value.lowercased()
        editWorkerInfo.UserFlag    = userFlag.value
        editWorkerInfo.ActionFlag  = EnumEditType.Add.rawValue
        editWorkerInfoArray.append(editWorkerInfo)
        SeriveCenter.getInstance().syncToSerivce(workerInfoArray: editWorkerInfoArray)
    }
    
    
}



