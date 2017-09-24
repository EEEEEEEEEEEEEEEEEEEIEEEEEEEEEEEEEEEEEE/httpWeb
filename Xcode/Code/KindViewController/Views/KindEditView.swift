//
//  KindEditView.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class KindEditView: UIView {

    let selectAllButton = UIButton(type: UIButtonType.custom)
    let selectOneButton = UIButton(type: UIButtonType.custom)
    let cancelButton    = UIButton(type: UIButtonType.custom)
    let deleteButton    = UIButton(type: UIButtonType.custom)
    
    //MARK:*********☆*********☆*********☆*********☆*********☆*********☆*********
    //MARK:required init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        InitializaInterface()
        
    }
    //MARK:初始化UI
    func InitializaInterface() {
        
        self.backgroundColor = UIColor.init(colorLiteralRed: 166/255.0, green: 182/255.0, blue: 191/255.0, alpha: 1.0)
        
        
        selectAllButton.titleLabel?.textColor = UIColor.black
        selectAllButton.setTitle(NSLocalizedString("SelectAll", comment: "全选"), for: .normal)
        selectAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(selectAllButton)
        selectAllButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        
        selectOneButton.titleLabel?.textColor = UIColor.black
        selectOneButton.setTitle(NSLocalizedString("SelectOne", comment: "单选"), for: .normal)
        selectOneButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(selectOneButton)
        selectOneButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(selectAllButton.snp.right)
            make.width.equalToSuperview().multipliedBy(0.23)
        }
        
        cancelButton.titleLabel?.textColor = UIColor.black
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: "取消"), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(selectOneButton.snp.right)
            make.width.equalToSuperview().multipliedBy(0.23)
        }
        
        
        deleteButton.titleLabel?.textColor = UIColor.black
        deleteButton.setTitle(NSLocalizedString("Delete", comment: "删除"), for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(cancelButton.snp.right)
            make.width.equalToSuperview().multipliedBy(0.23)
        }
    }
}





