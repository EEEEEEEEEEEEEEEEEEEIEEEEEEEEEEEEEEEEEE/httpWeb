//
//  ResultInfo.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class ResultInfo: NSObject, Mappable {
    
    // Result Code (0:Success, 9999:Error)
    var resultIdValue: Int? {
        didSet{
            ResultId = EnumHubResult(rawValue: resultIdValue!)
        }
    }
    
    var ResultId: EnumHubResult?
    var Message: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        resultIdValue <- map["ResultId"]
        Message       <- map["Message"]
    }
}
