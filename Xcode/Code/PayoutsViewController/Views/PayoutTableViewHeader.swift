//
//  PayoutTableViewHeader.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class PayoutTableViewHeader: UIView {

    let itemNoLabel = BaseLabel()
    let paidOnLabel = BaseLabel()
    let amountLabel = BaseLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.85, alpha: 1)
        
        itemNoLabel.text          = "No"
        itemNoLabel.textColor     = UIColor.darkGray
        itemNoLabel.textAlignment = .center
        itemNoLabel.leftInset     = 10
        itemNoLabel.font          = CommonFont14()
        itemNoLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(itemNoLabel)
        itemNoLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        paidOnLabel.text          = "PaidOn"
        paidOnLabel.textColor     = UIColor.darkGray
        paidOnLabel.textAlignment = .center
        paidOnLabel.leftInset     = 10
        paidOnLabel.font          = CommonFont14()
        paidOnLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(paidOnLabel)
        paidOnLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(itemNoLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        amountLabel.text          = "Amount(M)"
        amountLabel.textColor     = UIColor.darkGray
        amountLabel.textAlignment = .center
        amountLabel.leftInset     = 10
        amountLabel.font          = CommonFont14()
        amountLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(paidOnLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
