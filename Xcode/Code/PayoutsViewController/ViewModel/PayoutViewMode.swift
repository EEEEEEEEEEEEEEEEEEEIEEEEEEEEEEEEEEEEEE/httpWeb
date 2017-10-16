//
//  PayoutViewMode.swift
//  Xcode
//
//  Created by Hanxun on 2017/10/11.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class PayoutViewMode: NSObject {
    let disposeBag = DisposeBag()
    let seriveCenter = SeriveCenter.getInstance()
    
    /// input
    var searchRxIn    = Variable<String>("")
    var coinTypeRxIn  = Variable<EnumCurrency>(EnumCurrency.BTC)
    
    /// output
    var currentWorkerArrayRx    = Variable<[PayoutsModel]>([PayoutsModel]())  // 当前显示的数据(可能是off,noRep,LowHR等)
    var currentWorkerArrayRxOut = Variable<[PayoutsModel]>([PayoutsModel]())  // 过滤后的数据,真正显示数据
    
    func initData() {
        
        /* 数据 */
        Observable.combineLatest(coinTypeRxIn.asObservable(),
                                 seriveCenter.workerGroupArrayInfoRxOut.asObservable(),
                                 seriveCenter.currentPayoutArrayRxOut.asObservable())
            .subscribe(onNext: { (coinType, selectGroupInfo, allArray) in
                // 当前选择的组中没有本视图控制器的币种
                if coinType.description != selectGroupInfo.CoinType {
                    self.currentWorkerArrayRx.value.removeAll()
                    return
                }
                self.currentWorkerArrayRx.value = allArray
            }).addDisposableTo(disposeBag)
        
        /* 搜索过滤 */
        Observable.combineLatest(searchRxIn.asObservable(),
                                 currentWorkerArrayRx.asObservable())
            .subscribe(onNext: { (search, arrayRx) in
                let filterBuff = self.searchFilter(search: search, arrayRx: arrayRx)
                self.currentWorkerArrayRxOut.value = filterBuff
            }).addDisposableTo(disposeBag)
    }
    
    func searchFilter(search: String, arrayRx: [PayoutsModel]) -> [PayoutsModel] {
        
        if search.characters.count < 1 {
            return arrayRx
        }
        let lowSearch = search.uppercased()
        var newArray = [PayoutsModel]()
        for element in arrayRx {
            if (element.dateTime?.contains(lowSearch))! {
                newArray.append(element)
            }
        }
        print("\(newArray.count)")
        return newArray
    }
}
