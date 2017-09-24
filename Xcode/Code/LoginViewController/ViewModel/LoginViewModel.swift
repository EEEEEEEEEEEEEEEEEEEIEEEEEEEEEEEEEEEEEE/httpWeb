//
//  LoginViewModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/8.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel {
    
    //MARK: output
    let loginButtonEnabled: Driver<Bool>
    let loginResult: Driver<EnumResult>
    
    init(input: (username: Driver<String>, password: Driver<String>, loginTaps: Driver<Void>)) {
        
        loginButtonEnabled = Driver.combineLatest(input.username, input.password) {
            ($0.characters.count >= 6) && ($1.characters.count >= 6)
        }.asDriver()
        
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            ($0, $1)
        }
        
        loginResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest {  (username, password) in
                return ValidationService.instance.login(username, password: password)
                    .asDriver(onErrorJustReturn: .failed(message: "连接超时"))
            }
    }
}
