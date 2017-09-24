//
//  workerTableViewHeader.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/19.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class workerTableViewHeader: UIView {
    var numberLabel   = BaseLabel()
    var deviceIdLabel = BaseLabel()
    var RepHRLabel    = BaseLabel()
    var statusLabel   = BaseLabel()
    var timeLabel     = BaseLabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = RGBCOLOR(r: 166, 182, 191)
        self.backgroundColor = UIColor.init(white: 0.85, alpha: 1)
        
        numberLabel.text = "No"
        numberLabel.textColor = UIColor.darkGray
        numberLabel.textAlignment = .center
        numberLabel.leftInset = 10
        numberLabel.font = CommonFont14()
        self.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        deviceIdLabel.text = "Name"
        deviceIdLabel.textColor = UIColor.darkGray
        deviceIdLabel.textAlignment = .center
        deviceIdLabel.leftInset = 10
        deviceIdLabel.font = CommonFont14()
        self.addSubview(deviceIdLabel)
        deviceIdLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(numberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        RepHRLabel.text = "Rep(MH/R)"
        RepHRLabel.textColor = UIColor.darkGray
        RepHRLabel.textAlignment = .center
        RepHRLabel.font = CommonFont14()
        self.addSubview(RepHRLabel)
        RepHRLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(deviceIdLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        statusLabel.text = "Status"
        statusLabel.textColor = UIColor.darkGray
        statusLabel.textAlignment = .center
        statusLabel.leftInset = 10
        statusLabel.font = CommonFont14()
        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(RepHRLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        timeLabel.text = "Time"
        timeLabel.textColor = UIColor.darkGray
        timeLabel.textAlignment = .center
        timeLabel.leftInset = 10
        timeLabel.font = CommonFont14()
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(statusLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
    }
}






