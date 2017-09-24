//
//  PoolSearchView.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PoolSearchView: UIView {

    var searchBar = UISearchBar()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.90, alpha: 1)
        
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = .search
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = UIColor.green
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(1)
            make.right.bottom.equalToSuperview().offset(-1)
        }
    }

}
