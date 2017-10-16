//
//  ProjectConfig.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class ProjectConfig: NSObject {
    
    static let instance = ProjectConfig()
    
    var SignalRServerUrl: String?
    
    class func getInstance() -> ProjectConfig {
        return instance
    }
    
    public func initData() {
//        SignalRServerUrl = "http://182.162.147.161:9110"
//        SignalRServerUrl = "http://182.162.103.36:9110"
        SignalRServerUrl = "http://182.162.103.37:9220"
//        SignalRServerUrl = "http://182.162.103.34:9220"
    }
}
