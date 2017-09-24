//
//  WorkerTableViewCell.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/21.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class WorkerTableViewCell: UITableViewCell {

    var numberLabel   = BaseLabel()
    var deviceIdLabel = BaseLabel()
    var RepHRLabel    = BaseLabel()
    var statusLabel   = BaseLabel()
    var timeLabel     = BaseLabel()
    let lineSeparator = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        numberLabel.text = "Number"
        numberLabel.textColor = UIColor.darkGray
        numberLabel.textAlignment = .center
        numberLabel.leftInset = 10
        numberLabel.font = CommonFont14()
        self.contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        deviceIdLabel.text = "ItemName"
        deviceIdLabel.textColor = UIColor.darkGray
        deviceIdLabel.textAlignment = .center
        deviceIdLabel.leftInset = 10
        deviceIdLabel.font = CommonFont14()
        self.contentView.addSubview(deviceIdLabel)
        deviceIdLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(numberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        RepHRLabel.text = "Rep(H/R)"
        RepHRLabel.textColor = UIColor.darkGray
        RepHRLabel.textAlignment = .center
        RepHRLabel.leftInset = 10
        RepHRLabel.font = CommonFont14()
        self.contentView.addSubview(RepHRLabel)
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
        self.contentView.addSubview(statusLabel)
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
        self.contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(statusLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        self.contentView.addSubview(lineSeparator)
        lineSeparator.backgroundColor = CommonSeparatorLineColor()
        lineSeparator.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(lineSeparator.superview!)
            make.height.equalTo(1)
        }
    }
}
