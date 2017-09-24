//
//  PoolTableViewCell.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class PoolTableViewCell: UITableViewCell {

    let numberLabel   = BaseLabel()
    let poolNameLabel = BaseLabel()
    let workerIdLabel = BaseLabel()
    let coinTypeLabel = BaseLabel()
//    let observedLabel = BaseLabel()
    let observedImage = UIImageView()
    let lineSeparator = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        numberLabel.text = "No"
        numberLabel.textColor = UIColor.darkGray
        numberLabel.textAlignment = .center
        numberLabel.leftInset = 10
        numberLabel.font = CommonFont14()
        self.contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        poolNameLabel.text = "PoolName"
        poolNameLabel.textColor = UIColor.darkGray
        poolNameLabel.textAlignment = .center
        poolNameLabel.leftInset = 10
        poolNameLabel.font = CommonFont14()
        self.contentView.addSubview(poolNameLabel)
        poolNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(numberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        workerIdLabel.text = "WorkerId"
        workerIdLabel.textColor = UIColor.darkGray
        workerIdLabel.textAlignment = .center
        workerIdLabel.leftInset = 10
        workerIdLabel.font = CommonFont14()
        self.contentView.addSubview(workerIdLabel)
        workerIdLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(poolNameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        coinTypeLabel.text = "CoinType"
        coinTypeLabel.textColor = UIColor.darkGray
        coinTypeLabel.textAlignment = .center
        coinTypeLabel.leftInset = 10
        coinTypeLabel.font = CommonFont14()
        self.contentView.addSubview(coinTypeLabel)
        coinTypeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(workerIdLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        observedImage.image = UIImage.init(named: "selectOff")
        self.contentView.addSubview(observedImage)
        observedImage.snp.makeConstraints { make in
            make.left.equalTo(coinTypeLabel.snp.right).offset(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        self.contentView.addSubview(lineSeparator)
        lineSeparator.backgroundColor = CommonSeparatorLineColor()
        lineSeparator.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(lineSeparator.superview!)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
