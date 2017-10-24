//
//  EnumStatus.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/8.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


enum EnumResult: Int {
    case success  = 1
    case failed   = 0
    case empty    = 2
}


extension EnumResult {
    var isValid: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}

extension EnumResult {
    var textColor: UIColor {
        switch self {
        case .success:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}

extension EnumResult {
    var backgroundColor: UIColor {
        switch self {
        case .success:
            return UIColor.green
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}


extension EnumResult {
    var description: String {
        switch self {
        case .success:
            return "登陆成功"
        case .empty:
            return ""
        case .failed:
            return "登陆失败"
        }
    }
}

extension EnumResult {
    var text: String {
        switch self {
        case .success:
            return "登陆成功"
        case .empty:
            return "不能为空"
        case .failed:
            return "登陆失败"
        }
    }
}



