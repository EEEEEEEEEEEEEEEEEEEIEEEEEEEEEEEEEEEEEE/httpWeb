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
    var kindViewModel: KindViewModel!
    var editView: KindEditView!
    
    private lazy var tableView: UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 104, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 104 - 49))
        tabView.allowsMultipleSelectionDuringEditing = true
        tabView.delegate = self
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
        
        /// 初始化
        kindViewModel = KindViewModel()
        kindViewModel.initSearch()
        
        /// navBar
        let navBarView = NavBarView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        self.view.addSubview(navBarView)
        navBarView.titleLabel.text = "EtherChain"
        navBarView.leftButton.setTitle("", for: .normal)
        navBarView.rightButton.setTitle("Login", for: .normal)
        
        
        /// SearchBar
        let searchBarView = KindSearchView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 40))
        self.view.addSubview(searchBarView)
        searchBarView.searchBar.rx.text.orEmpty.bind(to: kindViewModel.searchRx).addDisposableTo(disposeBag)
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
        kindViewModel.kindArrayRx.drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: KindTableViewCell.self)) { (row, element, cell) in
            cell.numberLabel.text   = "\(row)"
            cell.workerIdLabel.text = element.workerId?.uppercased()
            cell.coinTypeLabel.text = element.coinType
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





