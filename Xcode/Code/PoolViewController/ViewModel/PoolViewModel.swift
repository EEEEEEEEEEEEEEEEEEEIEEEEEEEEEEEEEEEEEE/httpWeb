//
//  stopViewModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/18.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PoolViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    
    /// input
    var searchRx = Variable<String>("")
    var poolIndexRxIn  = Variable<Int>(0)
    var groupIndexRxIn = Variable<Int>(0)
    
    /// output
    var poolArrayRxOut        = Variable<[WorkerInfo]>([WorkerInfo]())
    var miningPoolArrayRxOut  = Variable<[String]>([String]())
    var workerGroupArrayRxOut = Variable<[String]>([String]())
    
    var requestChangeWokersResult = Variable<ResultInfo>(ResultInfo())
    
    // 解决不了双向绑定，只能先这样用(解决3和4界面的选择项显示同步)
    var currentPoolIndexRxOut  = Variable<Int>(0)
    var currentGroupIndexRxOut = Variable<Int>(0)
    
    
    override init() {
        
        /* 选项有改变 */
        poolIndexRxIn.asObservable().subscribe(onNext: { (value) in
            SeriveCenter.getInstance().poolSelectIndexRxIn.value  = value
        }).addDisposableTo(disposeBag)
        
        groupIndexRxIn.asObservable().subscribe(onNext: { (value) in
            SeriveCenter.getInstance().groupSelectIndexRxIn.value = value
        }).addDisposableTo(disposeBag)
        
    }
    
    
    func initData() {
        
        /* 选择项显示同步 */
        SeriveCenter.getInstance().poolSelectIndexRxIn.asObservable().subscribe(onNext: { (value) in
            self.currentPoolIndexRxOut.value = value
        }).addDisposableTo(disposeBag)
        
        SeriveCenter.getInstance().groupSelectIndexRxIn.asObservable().subscribe(onNext: { (value) in
            self.currentGroupIndexRxOut.value = value
        }).addDisposableTo(disposeBag)
        
        
        /* cell数据 */
        SeriveCenter.getInstance().currentAllWorkerInfoArrayRxOut.asObservable().subscribe(onNext : { (value) in
            self.poolArrayRxOut.value = value
        }).addDisposableTo(disposeBag)
        
        
        /* 选择项显示时需要的cell数据 */
        SeriveCenter.getInstance().miningPoolArrayRxOut.asObservable().subscribe(onNext: { (value) in
            self.miningPoolArrayRxOut.value = value
        }).addDisposableTo(disposeBag)
        
        SeriveCenter.getInstance().workerGroupArrayRxOut.asObservable().subscribe(onNext: { (value) in
            self.workerGroupArrayRxOut.value = value
        }).addDisposableTo(disposeBag)
        
        
        /* 添加删除的请求返回 */
        SeriveCenter.getInstance().requestChangeWokersResult.asObservable().subscribe(onNext: { (value) in
            self.requestChangeWokersResult.value = value
        }).addDisposableTo(disposeBag)
    }
    
    public func initSearch() {
        Observable.combineLatest(searchRx.asObservable(),
                                 SeriveCenter.getInstance().currentAllWorkerInfoArrayRxOut.asObservable())
            .subscribe(onNext: { (search , arrayRx) in
                let filterBuff = self.searchFilter(search: search, arrayRx: arrayRx)
                self.poolArrayRxOut.value = filterBuff
        }).addDisposableTo(disposeBag)
        
        self.initData()
    }
    
    func searchFilter(search: String, arrayRx: [WorkerInfo]) -> [WorkerInfo] {
        
        if search.characters.count < 1 {
            return arrayRx
        }
        let lowSearch = search.uppercased()
        var newArray = [WorkerInfo]()
        for element in arrayRx {
            if (element.WorkerId?.contains(lowSearch))! {
                newArray.append(element)
            }
        }
        print("\(newArray.count)")
        return newArray
    }
    
    
    
    /* cell有勾选事件 */
    public func cellSelectHandle(cellRow: Int) {
        let selectWorkerInfo: WorkerInfo = SeriveCenter.getInstance().currentAllWorkerInfoArrayRxOut.value[cellRow]
        if selectWorkerInfo.UserFlag == true {
            selectWorkerInfo.UserFlag = false
        } else {
            selectWorkerInfo.UserFlag = true
        }
        // 更新数据库，和 更改 currentAllWorkerInfoArrayRxOut 中的值，因为他是一个观察者，所以必须得赋值才会有事件产生
        SeriveCenter.getInstance().databaseOfSelectMarkChange(object: selectWorkerInfo)
        SeriveCenter.getInstance().currentAllWorkerInfoArrayRxOut.value[cellRow] = selectWorkerInfo
    }
    
    /* 删除WorkerInfo组 */
    public func syncDataHandle(deleteBuff: [WorkerInfo]) {
        SeriveCenter.getInstance().syncToSerivce(workerInfoArray: deleteBuff)
    }
}












