//
//  WorkerViewModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/13.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WorkerViewModel {
    
    /// input
    var searchRx = Variable<String>("")
    var problemRx = Variable<Bool>(true)
    
    /// output
    let disposeBag = DisposeBag()
    var workerArrayRx: Driver<[WorkerModel]>
    var workerArray = [WorkerModel]()
    
    var okNumberRx    = Observable<Int>.never()
    var offNumberRx   = Observable<Int>.never()
    var noRepNumberRx = Observable<Int>.never()
    var lowHRNumberRx = Observable<Int>.never()
    var test = Driver<String>.never()
    
    
    //MARK: 1.请求数据， 2.统计出数据，并发送事件
    init(input: (problem: Driver<Void>, search: Driver<String>)) {
        
        workerArrayRx = Provider.request(.workers).mapArray(WorkerModel.self).asDriver(onErrorJustReturn: [])
        workerArrayRx.asObservable().subscribe(onNext: {
            self.workerArray = $0 as [WorkerModel]
            var okNumber = 0
            var noRepNumber = 0
            var lowHRNumber = 0
            for element in self.workerArray {
                if element.repHR! > 150000000 {
                    okNumber += 1
                }
                else if element.repHR! > 0 { lowHRNumber += 1 }
                else { noRepNumber += 1}
            }
            self.okNumberRx    = .just(okNumber)
            self.noRepNumberRx = .just(noRepNumber)
            self.lowHRNumberRx = .just(lowHRNumber)
        }).addDisposableTo(disposeBag)
    }
    
    //MARK: 搜索
    func initSearch() {
        DispatchQueue.global().async {
            let timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.timerRequest), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .commonModes)
            RunLoop.current.run()
        }
        
        workerArrayRx = Driver.combineLatest(searchRx.asDriver(), workerArrayRx).flatMapLatest { (search, arrayRx) in
            return self.searchFilter(search: search, arrayRx: arrayRx).asDriver(onErrorJustReturn: [])
        }
    }
    
    func searchFilter(search: String, arrayRx: [WorkerModel]) -> Observable<[WorkerModel]> {
        
        if search.characters.count < 1 {
            return .just(arrayRx)
        }
        let lowSearch = search.lowercased()
        var newArray = [WorkerModel]()
        for element in arrayRx {
            if (element.worker?.contains(lowSearch))! {
                newArray.append(element)
            }
        }
        print("\(newArray.count)")
        return .just(newArray)
    }
    
    //MARK: 定时请求刷新数据
    @objc private func timerRequest() {
        workerArrayRx = Provider.request(.workers).mapArray(WorkerModel.self).asDriver(onErrorJustReturn: [])
        workerArrayRx.asObservable().subscribe(onNext: {
            self.workerArray = $0 as [WorkerModel]
            var okNumber = 0
            var noRepNumber = 0
            var lowHRNumber = 0
            for element in self.workerArray {
                if element.repHR! > 150000000 {
                    okNumber += 1
                }
                else if element.repHR! > 0 { lowHRNumber += 1 }
                else { noRepNumber += 1}
            }
            self.okNumberRx    = .just(okNumber)
            self.noRepNumberRx = .just(noRepNumber)
            self.lowHRNumberRx = .just(lowHRNumber)
        }).addDisposableTo(disposeBag)
    }
}
