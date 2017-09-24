//
//  MoyaAPI.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/12.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import Moya

/// 这个可能需要变化
let miner   = "c0c00cd1d93fb7e3f7d34bdd9007e360ef6c2556"

let BaseURL = "https://api.ethermine.org"
let BaseURLOther = "https://etherchain.org"

let PayoutsPath = "/miner/\(miner)/payouts"
let WorkersPath = "/miner/\(miner)/workers"
let TxPath      = "/api/tx/"


let Provider = RxMoyaProvider<Service>()

public enum Service {
    case payouts
    case workers
    case Tx(tailURL: String)
}


extension Service: TargetType {

    public var baseURL: URL {
        switch self {
        case .payouts, .workers:
            return URL(string: BaseURL)!
        case .Tx:
            return URL(string: BaseURLOther)!
        }
    }
    
    public var path: String {
        switch self {
        case .payouts:
            return PayoutsPath
        case .workers:
            return WorkersPath
        case let .Tx(tailURL):
            return TxPath + tailURL
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .payouts, .workers, .Tx:
            return .get
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .payouts, .workers, .Tx:
            return URLEncoding.default
        }
    }
    
    public var parameters: [String : Any]? {
        return nil
    }
    
    public var sampleData: Data {
        switch self {
        case .payouts, .workers, .Tx:
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    public var task: Task {
        switch self {
        case .payouts, .workers, .Tx:
            return .request
        }
    }
    
    public var validate: Bool {
        return false
    }
    
}

//class MoyaAPI: NSObject {
//
//}



