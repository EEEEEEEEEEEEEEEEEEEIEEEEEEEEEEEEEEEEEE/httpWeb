//
//  ValidationService.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/8.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 模拟假请求

class ValidationService {
    static let instance = ValidationService()
    
    func login(_ username: String, password: String) -> Observable<EnumResult> {
        if username == password {
            return .just(.success(message: "登陆成功"))
        }
        return .just(.failed(message: "登陆失败"))
    }
    
    func validateUsername(_ username: String) -> Observable<EnumResult> {
        if username.characters.count >= 6 {
            return .just(.success(message: "用户名可用"))
        }
        else if username.characters.count == 0 {
            return .just(.empty)
        }
        return .just(.failed(message: "至少6个字符"))
    }
    
    func validatePhone(_ phone: String) -> Observable<EnumResult> {
        if phone.isPhoneNumber {
            return .just(.success(message: "号码有效"))
        }
        else if phone.characters.count == 0 {
            return .just(.empty)
        }
        return .just(.failed(message: "号码无效"))
    }
}
