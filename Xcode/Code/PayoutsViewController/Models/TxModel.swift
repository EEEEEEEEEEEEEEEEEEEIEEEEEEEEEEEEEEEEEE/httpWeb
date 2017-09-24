//
//  TxModel.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/13.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import ObjectMapper

class TxModel: Mappable {
    
    var hash: String?
    var sender: String?
    var recipient: String?
    var accountNonce: String?
    var price: Int?
    var gasLimit: Int?
    var amount: Int?
    var block_id: Int?
    var time: String?
    var newContract: Int?
    var isContractTx: Any?
    var blockHash: String?
    var parentHash: String?
    var txIndex: Any?
    var gasUsed: Int?
    var type: String?  {
        didSet{
            type = type! + "123"
        }
    }

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        hash         <- map["hash"]
        sender       <- map["sender"]
        recipient    <- map["recipient"]
        accountNonce <- map["accountNonce"]
        price        <- map["price"]
        gasLimit     <- map["gasLimit"]
        amount       <- map["amount"]
        block_id     <- map["block_id"]
        time         <- map["time"]
        newContract  <- map["newContract"]
        isContractTx <- map["isContractTx"]
        blockHash    <- map["blockHash"]
        parentHash   <- map["parentHash"]
        txIndex      <- map["txIndex"]
        gasUsed      <- map["gasUsed"]
        type         <- map["type"]
    }
}

/*
{
    "status":1,
    "data":[
    {
    "hash":"0x513b91ed34d8fa0faab967ff4573bcab0c4e45d85f39d0c3a73a4542b244a56d",
    "sender":"0xea674fdde714fd979de3edf0f56aa9716b898ec8",
    "recipient":"0xc0c00cd1d93fb7e3f7d34bdd9007e360ef6c2556",
    "accountNonce":"3215208",
    "price":21000000000,
    "gasLimit":50000,
    "amount":1003531982915411300,
    "block_id":4264324,
    "time":"2017-09-12T01:35:33.000Z",
    "newContract":0,
    "isContractTx":null,
    "blockHash":"0x7ab5e31f3c2ed6ee5201251aed8afc64e930d9c5534dfdc5d92ab252209d3878",
    "parentHash":"0x513b91ed34d8fa0faab967ff4573bcab0c4e45d85f39d0c3a73a4542b244a56d",
    "txIndex":null,
    "gasUsed":21000,
    "type":"tx"
    }
    ]
}
*/

