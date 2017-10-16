//
//  PayoutsModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/12.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class PayoutsModel: Mappable {
    var start: Int?
    var end: Int?
    var amount: Float?
    var txHash: String?
    var paidOn: Int?
    
    var amountEthmine: Float? {
        didSet{
            if amountEthmine != nil {
                if amountEthmine! > Float(10000000.0) {
                    amount = Float(amountEthmine! / 1000000000000000000)
                } else {
                    amount = Float(amountEthmine!)
                }
            }
        }
    }
    
    var amountF2pool: String? {
        didSet{
            if amountF2pool != nil {
                amount = Float(amountF2pool!)
            }
        }
    }
    
    
    
    var dateTime: String? {
        get{
            return DateTime().timeStampToInteger(NSInteger(paidOn!))
        }
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        start    <- map["start"]
        end      <- map["end"]
        amountEthmine   <- map["amount"]
        txHash   <- map["txHash"]
        paidOn   <- map["paidOn"]
        
        
        /*f2pool*/
        amountF2pool   <- map["amount"]
        txHash   <- map["address"]
        paidOn   <- map["created_at"]
    }
}


/*
{
    "status":"OK",
    "data":[
    {
    "start":4263620,
    "end":4264213,
    "amount":1003531982915411300,
    "txHash":"0x513b91ed34d8fa0faab967ff4573bcab0c4e45d85f39d0c3a73a4542b244a56d",
    "paidOn":1505180023
    },
 */

/* f2pool
 
 ▿ 49 : 7 elements
 ▿ 0 : 2 elements
 - key : diff
 - value : 0
 ▿ 1 : 2 elements
 - key : hash_rate
 - value : 0
 ▿ 2 : 2 elements
 - key : address
 - value : LRFhFL8NEnfpG8i1FPaWPFs5YCAB6ogGWS
 ▿ 3 : 2 elements
 - key : amount
 - value : 17.78868022
 ▿ 4 : 2 elements
 - key : created_at
 - value : 1504483200
 ▿ 5 : 2 elements
 - key : currency
 - value : LTC
 ▿ 6 : 2 elements
 - key : transaction_id
 - value : f121d9fccc2abd282d20f5e33f6a94cac9dbb8f3cbfe451c367f7e5d1dbd8208
 (lldb)
 
 */



