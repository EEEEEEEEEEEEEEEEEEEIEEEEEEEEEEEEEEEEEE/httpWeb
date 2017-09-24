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


enum EnumResult {
    case success(message: String)
    case failed(message: String)
    case empty
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
        case let .success(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}



