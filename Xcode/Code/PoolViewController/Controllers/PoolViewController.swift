//
//  StopViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/18.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

class PoolViewController: UIViewController {

    var poolViewModel = PoolViewModel()
    let disposeBag = DisposeBag()
    
    lazy var searchView: PoolSearchView = {
        let search = PoolSearchView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 40))
        return search
    }()
    
    lazy var tableView: UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 104, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 104 - 49), style: .plain)
        tabView.delegate = self
        tabView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            print("刷新结束")
            tabView.mj_header.endRefreshing()
        })
        return tabView
    }()
    let reuseIdentifier = "\(PoolTableViewCell.self)"
    
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
        let navBarView = NavBarView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        navBarView.titleLabel.text = "EtherChain"
        navBarView.leftButton.setTitle("", for: .normal)
        navBarView.rightButton.setTitle("", for: .normal)
        self.view.addSubview(navBarView)
        
        /// SearchBar
        self.view.addSubview(searchView)
        poolViewModel.initSearch()
        searchView.searchBar.rx.text.orEmpty.bind(to: poolViewModel.searchRx).addDisposableTo(disposeBag)
        
        /// tableView
        self.view.addSubview(tableView)
        self.tableView.register(PoolTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        poolViewModel.poolArrayRx.drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PoolTableViewCell.self)) { (row, element, cell) in
            cell.numberLabel.text = "\(row)"
            cell.poolNameLabel.text = "EtherChain"
            cell.workerIdLabel.text = element.workerId?.uppercased()
            cell.coinTypeLabel.text = element.coinType
            cell.observedImage.image = UIImage.init(named: element.status! ? "selectOk" : "selectOff")
        }.addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let cell = self?.tableView.cellForRow(at: indexPath) as? PoolTableViewCell
            cell?.setSelected(false, animated: false)
            
        }).addDisposableTo(disposeBag)
    }
    
    func initData() {
        
    }
}


extension PoolViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let workerHeaderView = PoolTableViewHeader.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        return workerHeaderView
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let workerFooterView = WorkerTableViewFooter.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
//        workerViewModel.okNumberRx.map {"\($0)"}.bind(to: workerFooterView.normalNumberLabel.rx.text)
//            .addDisposableTo(disposeBag)
//        workerViewModel.offNumberRx.map {"\($0)"}.bind(to: workerFooterView.offNumberLabel.rx.text)
//            .addDisposableTo(disposeBag)
//        workerViewModel.noRepNumberRx.map {"\($0)"}.bind(to: workerFooterView.stopNumberLabel.rx.text)
//            .addDisposableTo(disposeBag)
//        workerViewModel.lowHRNumberRx.map {"\($0)"}.bind(to: workerFooterView.lowHRNumberLabel.rx.text)
//            .addDisposableTo(disposeBag)
        return workerFooterView
    }
}















