//
//  F2poolService.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import Alamofire

class F2poolService: NSObject {
    
    /// 账号信息
    let userKey = "9587ce626fc78670816aeda91d531a36"
    let account = "atm"
    let baseLognUrl = "https://www.f2pool.com/mining-user/"
    
    
    /// 从登陆获取Cookie
    public func getLoginCookie() {
        
        let loginString = baseLognUrl + userKey
        let loginUrl = URL(string: loginString)
        
        Alamofire.request(loginString).responseJSON { response in
            
            let  headerFields = response.response?.allHeaderFields as? [String: String]
            let  URL = response.request?.url
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields!, for: URL!)
            Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookies, for: loginUrl, mainDocumentURL: nil)
//                print(cookies)
            Alamofire.request(loginString).responseJSON { response in
                
                let  headerFields = response.response?.allHeaderFields as? [String: String]
                let  URL = response.request?.url
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields!, for: URL!)
                Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookies, for: loginUrl, mainDocumentURL: nil)
                //                print(cookies)
            }
        }
        
        
    }
    
    
    /// 原生方法
    public func getLoginCookies() {
        
        let loginUrl = baseLognUrl + userKey
//        let url = URL(string: loginUrl)
//        let jar = HTTPCookieStorage.shared
//        let cookieHeaderField = ["Set-Cookie": "key=value"]
//        let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: url!)
//        jar.setCookies(cookies, for: url, mainDocumentURL: url)
//        
//        var request = URLRequest(url: url!)
//        let headers = HTTPCookie.requestHeaderFields(with: cookies)
//        request.allHTTPHeaderFields = headers
        
        if let tmpURL = URL(string: loginUrl) {
            var request = URLRequest(url: tmpURL)
            request.httpMethod = "GET"
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 20
            let session = URLSession(configuration: sessionConfig)
//            let body = para?.data(using: String.Encoding.utf8)
            let task = session.uploadTask(with: request, from: nil, completionHandler: {
                (data, response, error) ->Void in
                print("123")
            })
            task.resume()
        }else{
//            result(nil, "请求地址出错")
        }
    }
}





