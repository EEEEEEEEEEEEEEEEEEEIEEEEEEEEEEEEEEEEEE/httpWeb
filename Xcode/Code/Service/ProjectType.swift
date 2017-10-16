//
//  ProjectType.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/25.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit



enum EnumWorkerStatus {
    case OK
    case OFF
    case NoRep
    case LowHR
}

extension EnumWorkerStatus {
    var description: String {
        switch self {
        case .OK:
            return "OK"
        case .OFF:
            return "OFF"
        case .NoRep:
            return "NoRep"
        case .LowHR:
            return "LowHR"
        }
    }
}


enum EnumWorkerType: Int {
    case All      = 0
    case Normal   = 1
    case PowerOFF = 2
    case UnReport = 3
    case LowHR    = 4
}

extension EnumWorkerType {
    var description: String {
        switch self {
        case .All:
            return "All"
        case .Normal:
            return "Normal"
        case .PowerOFF:
            return "PowerOFF"
        case .UnReport:
            return "UnReport"
        case .LowHR:
            return "Low H/R"
        }
    }
}




enum EnumCurrency: Int {
    case ETH = 0
    case BTC = 1
    case LTC = 2
}


extension EnumCurrency {
    var description: String {
        switch self {
        case .ETH:
            return "ETH"
        case .BTC:
            return "BTC"
        case .LTC:
            return "LTC"
        }
    }
}




enum EnumPool {
    case Ethermine
    case F2pool
}

extension EnumPool {
    var description: String {
        switch self {
        case .Ethermine:
            return "Ethermine"
        case .F2pool:
            return "F2Pool"
        }
    }
}






