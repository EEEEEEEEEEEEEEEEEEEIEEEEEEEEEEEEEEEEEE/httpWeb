//
//  WorkerETHViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/21.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh
import DateToolsSwift

/// 因为加了到pageView上面，坐标原点不再是原来的
class WorkerETHViewController: UIViewController {

    var workerViewModel: WorkerViewModel!
    let disposeBag = DisposeBag()
    var lastY: CGFloat = 0.0
    
    lazy var workerSearchView: WorkerSearchView = {
        let searchView = WorkerSearchView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        return searchView
    }()
    lazy var tableView: UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 60 - 40 - 49), style: .plain)
        tabView.separatorStyle = .none
        tabView.delegate = self
        tabView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            print("刷新结束")
            tabView.mj_header.endRefreshing()
        })
        return tabView
    }()
    let reuseIdentifier = "\(WorkerTableViewCell.self)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        
        /// SearchBar
        self.view.addSubview(workerSearchView)
        workerViewModel = WorkerViewModel(input: (problem: workerSearchView.problemButton.rx.tap.asDriver(),
                                                  search: workerSearchView.searchBar.rx.text.orEmpty.asDriver()))
        workerViewModel.initSearch()
        workerSearchView.searchBar.rx.text.orEmpty.bind(to: workerViewModel.searchRx).addDisposableTo(disposeBag)
        
        /// tableView
        self.view.addSubview(tableView)
        self.tableView.register(WorkerTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        workerViewModel.workerArrayRx.drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: WorkerTableViewCell.self)) { (row, element, cell) in
            cell.numberLabel.text      = "\(row)"
            cell.deviceIdLabel.text    = element.worker!.uppercased()
            cell.RepHRLabel.text       = String(format: "%.1f", Float(element.repHR! / 1000000))
            cell.statusLabel.text      = element.repHR! > 150000000 ? "Normal" : (element.repHR! > 0 ? "LowHR" : "NoRep" )
            cell.statusLabel.textColor = element.repHR! > 150000000 ? UIColor.green : (element.repHR! > 0 ? RGBCOLOR(r: 255, 139, 0) : UIColor.red)
            cell.timeLabel.text        = element.dateTime
            }.addDisposableTo(disposeBag)
    }
    
    func initData() {
    }
}

extension WorkerETHViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let workerHeaderView = workerTableViewHeader.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        return workerHeaderView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let workerFooterView = WorkerTableViewFooter.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        workerViewModel.okNumberRx.map {"\($0)"}.bind(to: workerFooterView.normalNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        workerViewModel.offNumberRx.map {"\($0)"}.bind(to: workerFooterView.offNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        workerViewModel.noRepNumberRx.map {"\($0)"}.bind(to: workerFooterView.stopNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        workerViewModel.lowHRNumberRx.map {"\($0)"}.bind(to: workerFooterView.lowHRNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        return workerFooterView
    }
}





