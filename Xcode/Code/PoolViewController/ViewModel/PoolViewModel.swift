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
    
    /// input
    var searchRx = Variable<String>("")
    
    /// output
    var poolArrayRx: Driver<[PoolModel]>
    
//    func getPoolGroup() -> Driver<[PoolModel]> {
//        return Provider.request(.workers).mapArray(PoolModel.self).asDriver(onErrorJustReturn: [])
//    }
    
    override init() {
        poolArrayRx = Provider.request(.workers).mapArray(PoolModel.self).asDriver(onErrorJustReturn: [])
    }
    
    public func initSearch() {
        poolArrayRx = Driver.combineLatest(searchRx.asDriver(), poolArrayRx).flatMapLatest { (search, arrayRx) in
            return self.searchFilter(search: search, arrayRx: arrayRx).asDriver(onErrorJustReturn: [])
        }
    }
    
    func searchFilter(search: String, arrayRx: [PoolModel]) -> Observable<[PoolModel]> {
        
        if search.characters.count < 1 {
            return .just(arrayRx)
        }
        let lowSearch = search.lowercased()
        var newArray = [PoolModel]()
        for element in arrayRx {
            if (element.workerId?.contains(lowSearch))! {
                newArray.append(element)
            }
        }
        print("\(newArray.count)")
        return .just(newArray)
    }
}
