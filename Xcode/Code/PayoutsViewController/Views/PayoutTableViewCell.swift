//
//  PayoutTableViewCell.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/12.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import SnapKit

class PayoutTableViewCell: UITableViewCell {

    let itemNoLabel = BaseLabel()
    let paidOnLabel = BaseLabel()
    let amountLabel = BaseLabel()
    let lineSeparator = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        itemNoLabel.text          = "No"
        itemNoLabel.textColor     = UIColor.darkGray
        itemNoLabel.textAlignment = .center
        itemNoLabel.leftInset     = 10
        itemNoLabel.font          = CommonFont14()
        itemNoLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(itemNoLabel)
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
        self.contentView.addSubview(paidOnLabel)
        paidOnLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(itemNoLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        amountLabel.text          = "Amount"
        amountLabel.textColor     = UIColor.darkGray
        amountLabel.textAlignment = .center
        amountLabel.font          = CommonFont14()
        amountLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(paidOnLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        self.contentView.addSubview(lineSeparator)
        lineSeparator.backgroundColor = CommonSeparatorLineColor()
        lineSeparator.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(lineSeparator.superview!)
            make.height.equalTo(1)
        }
    }
}





