//
//  StopViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/18.
//  Copyright © 2017年 Simon. All rights reserved.
// image

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

class PoolViewController: UIViewController {

    let disposeBag = DisposeBag()
    var poolViewModel = PoolViewModel()
    
    
    lazy var searchView: PoolSearchView = {
        let search = PoolSearchView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 40))
        return search
    }()
    
    lazy var tableView: UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 104, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 104 - 49), style: .plain)
        tabView.delegate = self
        tabView.separatorStyle = .none
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
        navBarView.titleLabel.text = "MiningPool"
        navBarView.leftButton.setTitle("PoolNull ", for: .normal)
        navBarView.leftViceButton.setTitle("GroupNull ", for: .normal)
        navBarView.rightButton.setTitle("", for: .normal)
        self.view.addSubview(navBarView)
        
        /* 一级: pool */
        navBarView.leftButton.rx.tap.subscribe(onNext: {
            navBarView.leftDropDown.show()
        }).addDisposableTo(disposeBag)
        
        poolViewModel.miningPoolArrayRxOut.asObservable().subscribe(onNext: { (value) in
            navBarView.leftDropDown.dataSource = value
        }).addDisposableTo(disposeBag)
        
        navBarView.leftDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.poolViewModel.poolIndexRxIn.value = index
        }
        
        /* 显示的数据必须从数据处理后来 */
        Observable.combineLatest(poolViewModel.currentPoolIndexRxOut.asObservable(),
                                 poolViewModel.miningPoolArrayRxOut.asObservable())
            .subscribe(onNext: { (poolIndex, poolArray) in
                if poolIndex < poolArray.count {
                    let selectPool = poolArray[poolIndex]
                    navBarView.leftButton.setTitle(selectPool, for: .normal)
                }
        }).addDisposableTo(disposeBag)
        
        /* 二级: workerGroup */
        navBarView.leftViceButton.rx.tap.subscribe(onNext: {
            navBarView.leftViceDropDown.show()
        }).addDisposableTo(disposeBag)
        
        poolViewModel.workerGroupArrayRxOut.asObservable().subscribe(onNext: { (value) in
            navBarView.leftViceDropDown.dataSource = value
        }).addDisposableTo(disposeBag)
        
        navBarView.leftViceDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.poolViewModel.groupIndexRxIn.value = index
        }
        
        Observable.combineLatest(poolViewModel.currentGroupIndexRxOut.asObservable(),
                                 poolViewModel.workerGroupArrayRxOut.asObservable())
            .subscribe(onNext: { (groupIndex, groupArray) in
                if groupIndex < groupArray.count {
                    let selectGroup = groupArray[groupIndex]
                    navBarView.leftViceButton.setTitle(selectGroup, for: .normal)
                }
        }).addDisposableTo(disposeBag)
        
        
        /// SearchBar
        self.view.addSubview(searchView)
        poolViewModel.initSearch()
        searchView.searchBar.rx.text.orEmpty.bind(to: poolViewModel.searchRx).addDisposableTo(disposeBag)
        
        
        /// tableView
        self.view.addSubview(tableView)
        self.tableView.register(PoolTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        poolViewModel.poolArrayRxOut.asDriver().drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PoolTableViewCell.self)) { (row, element, cell) in
            cell.numberLabel.text    = "\(row + 1)"
            cell.poolNameLabel.text  = element.MiningPool
            cell.groupNameLabel.text = element.WorkerGroup
            cell.workerIdLabel.text  = element.WorkerId
            cell.coinTypeLabel.text  = element.CoinType
            cell.observedImage.image = UIImage.init(named: element.UserFlag! ? "selectOk" : "selectOff")
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let cell = self?.tableView.cellForRow(at: indexPath) as? PoolTableViewCell
            cell?.setSelected(false, animated: false)
            self?.poolViewModel.cellSelectHandle(cellRow: indexPath.row)
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

    /*
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
 */
}















