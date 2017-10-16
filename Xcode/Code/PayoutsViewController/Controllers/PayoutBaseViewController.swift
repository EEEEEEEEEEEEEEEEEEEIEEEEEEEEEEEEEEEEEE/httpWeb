//
//  PayoutBaseViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/10/11.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import PopupDialog

class PayoutBaseViewController: UIViewController {

    let disposeBag      = DisposeBag()
    let payoutViewModel = PayoutViewMode()
    
    
    lazy var searchView: PoolSearchView = {
        let search = PoolSearchView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        return search
    }()
    
    lazy var tableView: UITableView = {
        let tabView = UITableView(frame:CGRect(x: 0, y: 40, width: SCREEN_WIDTH,
                                               height: SCREEN_HEIGHT - 60 - 40 - 49), style: .plain)
        tabView.delegate = self
        tabView.backgroundColor = CommonBackgroundColor()
        tabView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            print("刷新结束")
            tabView.mj_header.endRefreshing()
        })
        return tabView
    }()
    let reuseIdentifier = "\(PayoutTableViewCell.self)"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        
        
        payoutViewModel.initData()
        self.view.addSubview(searchView)
        searchView.searchBar.rx.text.orEmpty.bind(to: payoutViewModel.searchRxIn).addDisposableTo(disposeBag)
        
        
        /// tableView
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.view.addSubview(tableView)
        self.tableView.register(PayoutTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        payoutViewModel.currentWorkerArrayRxOut.asDriver()
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PayoutTableViewCell.self)) { (row, element, cell) in
                cell.itemNoLabel.text = "\(row + 1)"
                cell.paidOnLabel.text = element.dateTime
                cell.amountLabel.text = element.amount == nil ? "" : String(format: "%.5f", element.amount!)
            }.addDisposableTo(disposeBag)
        
        /*
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                return self?.viewModel.getTxData(index: indexPath.row).drive(onNext:{
                    let cell = self?.tableView.cellForRow(at: indexPath) as? PayoutTableViewCell
                    cell?.setSelected(false, animated: true)
                    let txArray = $0 as [TxModel]
                    self?.showPopupView(title: "Message", message: txArray[0].recipient!)
                }).addDisposableTo((self?.disposeBag)!)
            }).addDisposableTo(disposeBag)  */
        
    }
    
    //MARK: 弹出框显示
    private func showPopupView(title: String, message: String) {
        let popup = PopupDialog(title: title, message: message)
        popup.buttonAlignment = .horizontal
        popup.transitionStyle = .zoomIn
        let view = popup.viewController.view as! PopupDialogDefaultView
        view.titleColor = UIColor.black
        view.titleFont  = UIFont(name: "HelveticaNeue-Bold", size: 18)!
        view.messageColor = UIColor.darkGray
        view.messageFont = UIFont(name: "HelveticaNeue", size: 16)!
        self.present(popup, animated: false, completion: nil)
    }
}




extension PayoutBaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let workerHeaderView = PayoutTableViewHeader.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        return workerHeaderView
    }
}



