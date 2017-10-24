//
//  KindSearchView.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class KindSearchView: UIView {
    
//    var addCellButton    = UIButton(type: UIButtonType.custom)
//    var removeCellButton = UIButton(type: UIButtonType.custom)
    var searchBar = UISearchBar()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.90, alpha: 1)
        
        /*
        addCellButton.setImage(UIImage.init(named: "addCell"), for: .normal)
        addCellButton.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        addCellButton.layer.cornerRadius = 5
        addCellButton.showsTouchWhenHighlighted = true
        self.addSubview(addCellButton)
        addCellButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(30)
        }
        
        removeCellButton.setImage(UIImage.init(named: "removeCell"), for: .normal)
        removeCellButton.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        removeCellButton.layer.cornerRadius = 5
        removeCellButton.showsTouchWhenHighlighted = true
        self.addSubview(removeCellButton)
        removeCellButton.snp.makeConstraints { make in
            make.left.equalTo(addCellButton.snp.right).offset(5)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(30)
        }
        */
        
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = .search
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = UIColor.green
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(1)
            make.bottom.right.equalToSuperview().offset(-1)
//            make.left.equalTo(removeCellButton.snp.right)
        }
    }
}
