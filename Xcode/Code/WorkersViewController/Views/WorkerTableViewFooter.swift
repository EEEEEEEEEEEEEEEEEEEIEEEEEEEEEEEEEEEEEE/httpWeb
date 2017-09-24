//
//  WorkerTableViewFooter.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/20.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class WorkerTableViewFooter: UIView {
    
    var normalNameLabel   = BaseLabel()
    var normalNumberLabel = BaseLabel()
    var offNameLabel      = BaseLabel()
    var offNumberLabel    = BaseLabel()
    var stopNameLabel     = BaseLabel()
    var stopNumberLabel   = BaseLabel()
    var lowHRNameLabel    = BaseLabel()
    var lowHRNumberLabel  = BaseLabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(white: 0.85, alpha: 1)
        
        normalNameLabel.text = "OK"
        normalNameLabel.textColor = UIColor.darkGray
        normalNameLabel.font = CommonFont12()
        normalNameLabel.textAlignment = .center
        self.addSubview(normalNameLabel)
        normalNameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(22)
        }
        normalNumberLabel.text = "100"
        normalNumberLabel.textColor = UIColor.darkGray
        normalNumberLabel.font = CommonFont12()
        normalNumberLabel.textAlignment = .center
        self.addSubview(normalNumberLabel)
        normalNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(normalNameLabel.snp.bottom)
            make.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        offNameLabel.text = "OFF"
        offNameLabel.textColor = UIColor.darkGray
        offNameLabel.font = CommonFont12()
        offNameLabel.textAlignment = .center
        self.addSubview(offNameLabel)
        offNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(normalNameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(22)
        }
        offNumberLabel.text = "101"
        offNumberLabel.textColor = UIColor.darkGray
        offNumberLabel.font = CommonFont12()
        offNumberLabel.textAlignment = .center
        self.addSubview(offNumberLabel)
        offNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(normalNameLabel.snp.bottom)
            make.left.equalTo(normalNumberLabel.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        stopNameLabel.text = "NoRep"
        stopNameLabel.textColor = UIColor.darkGray
        stopNameLabel.font = CommonFont12()
        stopNameLabel.textAlignment = .center
        self.addSubview(stopNameLabel)
        stopNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(offNameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(22)
        }
        stopNumberLabel.text = "102"
        stopNumberLabel.textColor = UIColor.darkGray
        stopNumberLabel.font = CommonFont12()
        stopNumberLabel.textAlignment = .center
        self.addSubview(stopNumberLabel)
        stopNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(normalNameLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(offNumberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        lowHRNameLabel.text = "LowHR"
        lowHRNameLabel.textColor = UIColor.darkGray
        lowHRNameLabel.font = CommonFont12()
        lowHRNameLabel.textAlignment = .center
        self.addSubview(lowHRNameLabel)
        lowHRNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(stopNameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(22)
        }
        lowHRNumberLabel.text = "103"
        lowHRNumberLabel.textColor = UIColor.darkGray
        lowHRNumberLabel.font = CommonFont12()
        lowHRNumberLabel.textAlignment = .center
        self.addSubview(lowHRNumberLabel)
        lowHRNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(normalNameLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(stopNumberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
    }
}
