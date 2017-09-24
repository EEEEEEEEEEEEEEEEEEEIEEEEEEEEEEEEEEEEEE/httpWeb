//
//  KindViewModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/18.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class KindViewModel {
    
    /// input
    var searchRx = Variable<String>("")
    
    /// output
    var kindArrayRx: Driver<[KindModel]>
    
//    init(input: (addCell: Driver<Void>, removeCell: Driver<Void>)) {
    
    init() {
        kindArrayRx = Provider.request(.workers).mapArray(KindModel.self).asDriver(onErrorJustReturn: [])
    }
    
    public func initSearch() {
        kindArrayRx = Driver.combineLatest(searchRx.asDriver(), kindArrayRx).flatMapLatest { (search, arrayRx) in
            return self.searchFilter(search: search, arrayRx: arrayRx).asDriver(onErrorJustReturn: [])
        }
    }
    
    func searchFilter(search: String, arrayRx: [KindModel]) -> Observable<[KindModel]> {
        
        if search.characters.count < 1 {
            return .just(arrayRx)
        }
        let lowSearch = search.lowercased()
        var newArray = [KindModel]()
        for element in arrayRx {
            if (element.workerId?.contains(lowSearch))! {
                newArray.append(element)
            }
        }
        print("\(newArray.count)")
        return .just(newArray)
    }
}
