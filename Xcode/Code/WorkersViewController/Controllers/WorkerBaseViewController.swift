//
//  WorkerBaseViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/10/10.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

class WorkerBaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    var workerViewModel = WorkerViewMode()
    
    
    lazy var workerSearchView: WorkerSearchView = {
        let searchView = WorkerSearchView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        return searchView
    }()
    lazy var tableView: UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH,
                                                height: SCREEN_HEIGHT - 60 - 40 - 49), style: .plain)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        
        /// SearchBar
        workerViewModel.initData()
        self.view.addSubview(workerSearchView)
        workerSearchView.workerTypeButton.rx.tap.subscribe(onNext: {
            self.workerSearchView.workerTypeDropDown.show()
        }).addDisposableTo(disposeBag)
        workerSearchView.workerTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.workerViewModel.workerTypRxIn.value = EnumWorkerType(rawValue: index)!
            self.workerSearchView.workerTypeButton.setTitle(item, for: .normal)
        }
//        workerViewModel.coinTypeRxIn.value = EnumCurrency.ETH
        workerSearchView.searchBar.rx.text.orEmpty.bind(to: workerViewModel.searchRxIn).addDisposableTo(disposeBag)
        
        
        self.view.addSubview(tableView)
        self.tableView.register(WorkerTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        workerViewModel.currentWorkerArrayRxOut.asDriver()
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier,
                                      cellType: WorkerTableViewCell.self))
            { (row, element, cell) in
                cell.numberLabel.text = "\(row + 1)"
                cell.deviceIdLabel.text    = element.worker == nil ? "" : element.worker!.uppercased()
                cell.RepHRLabel.text       = element.repHR  == nil ? "Null" : String(format: "%.1f", Float(element.repHR! / 1000000))
                cell.statusLabel.text      = element.repHR  == nil ? "P/W OFF" : element.repHR! >= 150000000 ? "Normal" : (element.repHR! > 0 ? "LowHR" : "NoRep" )
                cell.statusLabel.textColor = element.repHR  == nil ? UIColor.red : element.repHR! >= 150000000 ? UIColor.green : (element.repHR! > 0 ? RGBCOLOR(r: 255, 139, 0) : UIColor.red)
                cell.timeLabel.text        = element.dateTime == nil ? "" : element.dateTime
                                        
        }.addDisposableTo(disposeBag)
    }
}




extension WorkerBaseViewController: UITableViewDelegate {
    
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
        workerViewModel.okNumberRxOut.asObservable().map {"\($0)"}.bind(to: workerFooterView.normalNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        workerViewModel.offNumberRxOut.asObservable().map {"\($0)"}.bind(to: workerFooterView.offNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        workerViewModel.noRepNumberRxOut.asObservable().map {"\($0)"}.bind(to: workerFooterView.stopNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        workerViewModel.lowHRNumberRxOut.asObservable().map {"\($0)"}.bind(to: workerFooterView.lowHRNumberLabel.rx.text)
            .addDisposableTo(disposeBag)
        return workerFooterView
    }
}


