//
//  WorkerViewMode.swift
//  Xcode
//
//  Created by Hanxun on 2017/10/10.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WorkerViewMode: NSObject {
    
    let disposeBag = DisposeBag()
    let seriveCenter = SeriveCenter.getInstance()
    
    /// input
    var searchRxIn    = Variable<String>("")
    var coinTypeRxIn  = Variable<EnumCurrency>(EnumCurrency.BTC)
    var workerTypRxIn = Variable<EnumWorkerType>(EnumWorkerType.All)
    
    /// output
    var currentWorkerArrayRx    = Variable<[WorkerModel]>([WorkerModel]())  // 当前显示的数据(可能是off,noRep,LowHR等)
    var currentWorkerArrayRxOut = Variable<[WorkerModel]>([WorkerModel]())  // 过滤后的数据,真正显示数据
    
//    var workerArrayRxOut = Variable<[WorkerModel]>([WorkerModel]()) //除OFF都包含
//    var okArrayRxOut     = Variable<[WorkerModel]>([WorkerModel]())
//    var offArrayRxOut    = Variable<[WorkerModel]>([WorkerModel]())
//    var noRepArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
//    var lowHRArrayRxOut  = Variable<[WorkerModel]>([WorkerModel]())
    
    var okNumberRxOut    = Variable<Int>(0)
    var offNumberRxOut   = Variable<Int>(0)
    var noRepNumberRxOut = Variable<Int>(0)
    var lowHRNumberRxOut = Variable<Int>(0)
    
    
    func initData() {
        
        /* 数据 */
        Observable.combineLatest(coinTypeRxIn.asObservable(),
                                 workerTypRxIn.asObservable(),
                                 seriveCenter.workerGroupArrayInfoRxOut.asObservable(),
                                 seriveCenter.workerArrayRxOut.asObservable(),
                                 seriveCenter.okArrayRxOut.asObservable(),
                                 seriveCenter.noRepArrayRxOut.asObservable(),
                                 seriveCenter.lowHRArrayRxOut.asObservable(),
                                 seriveCenter.offArrayRxOut.asObservable())
            .subscribe(onNext: { (coinType, workerType, selectGroupInfo, allArray, okArray, noRepArray, lowHRArray, offArray) in
                
                // 当前选择的组中没有本视图控制器的币种
                if coinType.description != selectGroupInfo.CoinType {
                    self.currentWorkerArrayRx.value.removeAll()
                    return
                }
                
                switch workerType {
                case .All:
                    self.currentWorkerArrayRx.value = allArray
                case .Normal:
                    self.currentWorkerArrayRx.value = okArray
                    
                case .UnReport:
                    self.currentWorkerArrayRx.value = noRepArray
                case .LowHR:
                    self.currentWorkerArrayRx.value = lowHRArray
                case .PowerOFF:
                    self.currentWorkerArrayRx.value = offArray
                }
                
//                self.okNumberRxOut.value    = self.seriveCenter.okNumberRxOut.value
//                self.offNumberRxOut.value   = self.seriveCenter.offNumberRxOut.value
//                self.noRepNumberRxOut.value = self.seriveCenter.noRepNumberRxOut.value
//                self.lowHRNumberRxOut.value = self.seriveCenter.lowHRNumberRxOut.value
                
            }).addDisposableTo(disposeBag)
        
        /* 数据统计 */
        Observable.combineLatest(coinTypeRxIn.asObservable(),
                                 seriveCenter.workerGroupArrayInfoRxOut.asObservable(),
                                 seriveCenter.okNumberRxOut.asObservable(),
                                 seriveCenter.offNumberRxOut.asObservable(),
                                 seriveCenter.noRepNumberRxOut.asObservable(),
                                 seriveCenter.lowHRNumberRxOut.asObservable())
            .subscribe(onNext: { (coinType, selectGroupInfo, okInt, offInt, noRepInt, lowHRInt) in
                
                // 当前选择的组中没有本视图控制器的币种
                if coinType.description != selectGroupInfo.CoinType {
                    self.okNumberRxOut.value    = 0
                    self.offNumberRxOut.value   = 0
                    self.noRepNumberRxOut.value = 0
                    self.lowHRNumberRxOut.value = 0
                    return
                }
                
                self.okNumberRxOut.value    = okInt
                self.offNumberRxOut.value   = offInt
                self.noRepNumberRxOut.value = noRepInt
                self.lowHRNumberRxOut.value = lowHRInt
                
            }).addDisposableTo(disposeBag)
        
        
        /* 搜索过滤 */
        Observable.combineLatest(searchRxIn.asObservable(),
                                 currentWorkerArrayRx.asObservable())
            .subscribe(onNext: { (search, arrayRx) in
                let filterBuff = self.searchFilter(search: search, arrayRx: arrayRx)
                self.currentWorkerArrayRxOut.value = filterBuff
            }).addDisposableTo(disposeBag)
    }
    
    
    func searchFilter(search: String, arrayRx: [WorkerModel]) -> [WorkerModel] {
        
        if search.characters.count < 1 {
            return arrayRx
        }
        let lowSearch = search.uppercased()
        var newArray = [WorkerModel]()
        for element in arrayRx {
            if (element.worker?.contains(lowSearch))! {
                newArray.append(element)
            }
        }
        print("\(newArray.count)")
        return newArray
    }
    
}




