//
//  ProjectConfig.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProjectConfig: NSObject {
    
    let disposeBag = DisposeBag()
    static let instance = ProjectConfig()
    class func getInstance() -> ProjectConfig {
        return instance
    }
    
    var SignalRServerUrl: String?
    var UserGroup       : String? = ""
    var UserID          : String? = ""
    var UserPassword    : String? = ""
    var UserName        : String? = ""
    var UserAuth        : Int?    = 0
    
    
    
    public func initData() {
        SignalRServerUrl = "http://182.162.103.37:9220"
//        SignalRServerUrl = "http://182.162.103.34:9220"
        
        /* 观察登陆的值 */
        let singalR = SingalRService.getInstance()
        singalR.loginResult.asObservable().skip(1).distinctUntilChanged().subscribe(onNext: { (loginInfo) in
            
            self.UserPassword = loginInfo.UserPassword == nil ? self.UserPassword : loginInfo.UserPassword
            
            self.UserGroup = loginInfo.UserGroup == nil ? self.UserGroup : loginInfo.UserGroup
            self.UserID    = loginInfo.UserID    == nil ? self.UserID    : loginInfo.UserID
            self.UserName  = loginInfo.UserName  == nil ? self.UserName  : loginInfo.UserName
            self.UserAuth  = loginInfo.UserAuth  == nil ? self.UserAuth  : loginInfo.UserAuth
            
        }).addDisposableTo(disposeBag)
    }
}








