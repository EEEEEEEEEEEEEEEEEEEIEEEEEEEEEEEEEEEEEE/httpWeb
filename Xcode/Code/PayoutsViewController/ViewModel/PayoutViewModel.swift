//
//  PayoutViewModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/13.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import ObjectMapper
import SwiftyJSON

class PayoutViewModel: NSObject {
    
    let disposeBag   = DisposeBag()
    var payoutsArray = [PayoutsModel]()
    var payoutsArrayRx: Driver<[PayoutsModel]>
    
    override init() {
        payoutsArrayRx = Provider.request(.payouts).mapArray(PayoutsModel.self).asDriver(onErrorJustReturn: [])
    }
    
    public func initData() {
        payoutsArrayRx.asObservable().subscribe(onNext: {
            self.payoutsArray = $0 as [PayoutsModel]
        }).addDisposableTo(disposeBag)
    }
    
    public func getTxData(index: NSInteger) -> Driver<[TxModel]> {
        let tailUrl = payoutsArray[index].txHash
        return Provider.request(.Tx(tailURL: tailUrl!)).mapArray(TxModel.self).asDriver(onErrorJustReturn: [])
    }
}
