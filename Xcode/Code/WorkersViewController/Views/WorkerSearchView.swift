//
//  WorkerSearchView.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/21.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DropDown

class WorkerSearchView: UIView {
    
    var problemButton = UIButton(type: UIButtonType.custom)
    var workerTypeButton = UIButton(type: UIButtonType.custom)
    var workerTypeDropDown = DropDown()
    var searchBar = UISearchBar()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.90, alpha: 1)
        
        workerTypeButton.setTitle("All(no off)", for: .normal)
        workerTypeButton.titleLabel?.font = CommonFont12()
        workerTypeButton.showsTouchWhenHighlighted = true
        workerTypeButton.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        workerTypeButton.layer.cornerRadius = 5
        self.addSubview(workerTypeButton)
        workerTypeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(100)
        }
        
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = .search
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = UIColor.green
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.right.equalToSuperview().offset(1)
            make.bottom.equalToSuperview().offset(-1)
            make.left.equalTo(workerTypeButton.snp.right)
        }
        
        self.initDropDown()
    }
    
    private func initDropDown() {
        
        workerTypeDropDown.anchorView   = self.workerTypeButton
        workerTypeDropDown.bottomOffset = CGPoint(x: 0, y: 37)
        workerTypeDropDown.dataSource   = ["All(no Off)", "Normal", "PowerOFF", "UnReport", "Low H/R"]
    }
}
