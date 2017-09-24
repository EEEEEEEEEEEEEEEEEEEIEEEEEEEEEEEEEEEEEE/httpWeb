//
//  RegisterViewModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/11.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewModel {
    
    /// input
//    let username = Variable<String>("")
//    let password = Variable<String>("")
//    let againPassword = Variable<String>("")
//    let phoneNumber = Variable<String>("")
    
    
    /// output
    let usernameCheck: Observable<EnumResult>
//    let passwordCheck: EnumResult
//    let againPasswordCheck: Observable<EnumResult>
//    let phoneNumberCheck: Observable<EnumResult>
//    
//    let registerButtonEnable: Observable<Bool>
    
    
    init(input: (username: Observable<String>, password: Observable<String>, againPassword: Observable<String>, phoneNumber: Observable<String>)) {
        
        // 这个要模拟请求服务器返回
        usernameCheck = input.username.asObservable().flatMapLatest{ username in
            return ValidationService.instance.validateUsername(username).observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.failed(message: "username检测出错"))
        }.shareReplay(1)
        
//        passwordCheck = input.password.subscribe(onNext: {
//            return .success(message: "123")
//        })
    }
}
