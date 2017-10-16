//
//  NavBarView.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/19.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import DropDown

class NavBarView: UIView {
    
    let leftButton       = UIButton(type: UIButtonType.custom)
    let leftViceButton   = UIButton(type: UIButtonType.custom)
    let leftDropDown     = DropDown()
    let leftViceDropDown = DropDown()
    
    let rightButton = UIButton(type: UIButtonType.custom)
    let titleLabel  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = CommonNavBarColor()
        
        self.addSubview(leftButton)
        leftButton.setTitle("左按键", for: .normal)
        leftButton.setTitleColor(UIColor.white, for: .normal)
        leftButton.layer.masksToBounds = true
        leftButton.layer.cornerRadius = 5
        leftButton.layer.borderWidth  = 1
        leftButton.layer.borderColor  = UIColor.white.cgColor
        leftButton.showsTouchWhenHighlighted = true
        leftButton.titleLabel?.font = CommonFont12()
//        leftButton.backgroundColor  = UIColor.lightGray
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.17)
            make.height.equalTo(30)
        }
        
        self.addSubview(leftViceButton)
        leftViceButton.setTitle("左副按键", for: .normal)
        leftViceButton.setTitleColor(UIColor.white, for: .normal)
        leftViceButton.layer.masksToBounds = true
        leftViceButton.layer.cornerRadius = 5
        leftViceButton.layer.borderWidth  = 1
        leftViceButton.layer.borderColor  = UIColor.white.cgColor
        leftViceButton.showsTouchWhenHighlighted = true
        leftViceButton.titleLabel?.font = CommonFont12()
//        leftViceButton.backgroundColor  = UIColor.lightGray
        leftViceButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.equalTo(leftButton.snp.right).offset(5)
            make.width.equalToSuperview().multipliedBy(0.17)
            make.height.equalTo(30)
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
        
        self.initDropDown()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initDropDown() {
        
        leftDropDown.anchorView   = self.leftButton
        leftDropDown.bottomOffset = CGPoint(x: 0, y: 37)
        
        leftViceDropDown.anchorView   = self.leftViceButton
        leftViceDropDown.bottomOffset = CGPoint(x: 0, y: 37)
    }
}





