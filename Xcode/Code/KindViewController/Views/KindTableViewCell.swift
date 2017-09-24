//
//  KindTableViewCell.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class KindTableViewCell: UITableViewCell {

    let numberLabel   = BaseLabel()
    let workerIdLabel = BaseLabel()
    let coinTypeLabel = BaseLabel()
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
    
    private func initView() {
        
        numberLabel.text = "No"
        numberLabel.textColor = UIColor.darkGray
        numberLabel.textAlignment = .center
        numberLabel.leftInset = 10
        numberLabel.font = CommonFont14()
        self.contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        workerIdLabel.text = "WorkerId"
        workerIdLabel.textColor = UIColor.darkGray
        workerIdLabel.textAlignment = .center
        workerIdLabel.leftInset = 10
        workerIdLabel.font = CommonFont14()
        self.contentView.addSubview(workerIdLabel)
        workerIdLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(numberLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.4)
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
