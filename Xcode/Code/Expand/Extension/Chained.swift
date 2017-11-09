//
//  Chained.swift
//  Xcode
//
//  Created by Hanxun on 2017/11/9.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class Chained: NSObject {
    
    fileprivate var successClosure: (() -> Void)?
    fileprivate var errorClosure: ((_ err: NSError) -> Void)?
    
    func success(_ closure: @escaping () -> Void) -> Chained {
        successClosure = closure
        return self
    }
    
    func error(_ closure: @escaping (_ err: NSError) -> Void) -> Chained {
        errorClosure = closure
        return self
    }
    
    func request(url: String) -> Chained {
        print("开始用 \(url) 请求了")
        ///在回调中，或者 闭包中实现逻辑，略
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2), execute: {
            self.successClosure!()
        })
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(4), execute: {
            self.errorClosure!(NSError(domain: "我在测试失败", code: 321, userInfo:  nil))
        })
        
        return self
    }
}
