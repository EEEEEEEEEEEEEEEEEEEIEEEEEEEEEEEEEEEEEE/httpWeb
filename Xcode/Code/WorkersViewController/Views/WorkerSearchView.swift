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

class WorkerSearchView: UIView {
    
    var problemButton = UIButton(type: UIButtonType.custom)
    var searchBar = UISearchBar()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.90, alpha: 1)
        
        problemButton.setImage(UIImage.init(named: "problem"), for: .normal)
        problemButton.showsTouchWhenHighlighted = true
        problemButton.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        problemButton.layer.cornerRadius = 5
        self.addSubview(problemButton)
        problemButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(30)
        }
        
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = .search
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = UIColor.green
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.right.equalToSuperview().offset(1)
            make.bottom.equalToSuperview().offset(-1)
            make.left.equalTo(problemButton.snp.right)
        }
    }
}
