//
//  NavBarView.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/19.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class NavBarView: UIView {
    
    let leftButton  = UIButton(type: UIButtonType.custom)
    let rightButton = UIButton(type: UIButtonType.custom)
    let titleLabel  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = CommonNavBarColor()
        
        self.addSubview(leftButton)
        leftButton.setTitle("左按键", for: .normal)
        leftButton.showsTouchWhenHighlighted = true
        leftButton.titleLabel?.font = CommonFont16()
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalTo(44)
        }
        
        self.addSubview(titleLabel)
        titleLabel.text = "Payout"
        titleLabel.textColor = UIColor.white
        titleLabel.font = CommonFont16()
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(44)
        }
        
        self.addSubview(rightButton)
        rightButton.setTitle("右按键", for: .normal)
        rightButton.showsTouchWhenHighlighted = true
        rightButton.titleLabel?.font = CommonFont16()
        rightButton.titleLabel?.textAlignment = .right
        rightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
