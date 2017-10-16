//
//  KindsViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class KindsViewController: UIViewController {

    let disposeBag = DisposeBag()
    var poolViewModel = PoolViewModel()
    var editView: KindEditView!
    
    
    private lazy var tableView: UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 104, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 104 - 49))
        tabView.allowsMultipleSelectionDuringEditing = true
        tabView.delegate = self
        tabView.separatorStyle = .none
        return tabView
    }()
    let reuseIdentifier = "\(KindTableViewCell.self)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initEditView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initView() {
        
        /// navBar
        let navBarView = NavBarView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        navBarView.titleLabel.text = "Config"
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
        poolViewModel.initSearch()
        let searchBarView = KindSearchView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 40))
        self.view.addSubview(searchBarView)
        searchBarView.searchBar.rx.text.orEmpty.bind(to: poolViewModel.searchRx).addDisposableTo(disposeBag)
        (searchBarView.removeCellButton.rx.tap).subscribe(onNext: {
            self.editView.isHidden = self.tableView.isEditing
            self.tableView.isEditing = !self.tableView.isEditing
        }).addDisposableTo(disposeBag)
        searchBarView.searchBar.rx.cancelButtonClicked.subscribe(onNext: {
            print("取消编辑")
        }).addDisposableTo(disposeBag)
        
        
        /// tableView
        self.view.addSubview(tableView)
        tableView.register(KindTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        poolViewModel.poolArrayRxOut.asDriver().drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: KindTableViewCell.self)) { (row, element, cell) in
            cell.numberLabel.text    = "\(row + 1)"
            cell.poolNameLabel.text  = element.MiningPool
            cell.groupNamelabel.text = element.WorkerGroup
            cell.workerIdLabel.text  = element.WorkerId
            cell.coinTypeLabel.text  = element.CoinType
        }.addDisposableTo(disposeBag)
    }
    
    
    
    //MARK: 编辑
    private func initEditView() {
        editView = KindEditView(frame: CGRect(x: 0, y: 104, width: SCREEN_WIDTH, height: 44))
        editView.isHidden = true
        self.view.addSubview(editView)
        
        editView.selectAllButton.rx.tap.subscribe(onNext: {
//            for i in 0..<FavoriteViewModel.getInstance().conditions.count {
//                let indexPath:IndexPath = IndexPath(row: i, section: 0)
//                mainTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.bottom)
//            }
        }).addDisposableTo(disposeBag)
        
        editView.selectOneButton.rx.tap.subscribe(onNext: {
//            for i in 0..<FavoriteViewModel.getInstance().conditions.count {
//                let indexPath:IndexPath = IndexPath(row: i, section: 0)
//                mainTableView.deselectRow(at: indexPath, animated: true)
//            }
        }).addDisposableTo(disposeBag)
        
        editView.cancelButton.rx.tap.subscribe(onNext: {
            self.tableView.setEditing(false, animated: true)
            self.editView.isHidden = true
        }).addDisposableTo(disposeBag)
        
        editView.deleteButton.rx.tap.subscribe(onNext: {
            self.tableView.setEditing(false, animated: true)
            self.editView.isHidden = true
            //
        }).addDisposableTo(disposeBag)
    }
}








extension KindsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let kindHeaderView = KindTableViewHeader(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        return kindHeaderView
    }
}





