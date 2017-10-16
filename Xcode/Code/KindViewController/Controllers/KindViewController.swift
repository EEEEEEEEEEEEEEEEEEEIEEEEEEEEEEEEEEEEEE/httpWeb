//
//  HomeViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/18.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

class KindViewController: UIViewController {

    var kindViewModel = PoolViewModel()
    let disposeBag = DisposeBag()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()//初始化UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10//垂直最小距离
        layout.minimumInteritemSpacing = 10//水平最小距离
        layout.itemSize = CGSize.init(width: 100, height:44)//item的大小
        
        let collectView = UICollectionView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 49), collectionViewLayout: layout)
        collectView.backgroundColor = CommonBackgroundColor()
        collectView.backgroundColor = UIColor.white
        collectView.showsVerticalScrollIndicator = false
        collectView.showsHorizontalScrollIndicator = false
        
        collectView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            print("4321")
            collectView.mj_header.endRefreshing()
        })
        
        return collectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func initView() {
        
        /// navBar
        let payoutNavBarView = NavBarView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        self.view.addSubview(payoutNavBarView)
        
        /// tableView
        self.view.addSubview(collectionView)
        self.collectionView.register(UINib(nibName: "KindCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KindCell")
//        kindViewModel.getKindGroup().drive(collectionView.rx.items(cellIdentifier: "KindCell", cellType: KindCollectionViewCell.self)) { (row, data, cell) in
//            cell.workerIdLabel.text = data.workerId
//            cell.coinTypeLabel.text = data.coinType
//        }.addDisposableTo(disposeBag)
    }
    
    func initData() {
        
    }
}


