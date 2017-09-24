//
//  PayoutETHViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/22.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import PopupDialog

class PayoutETHViewController: UIViewController {

    let viewModel = PayoutViewModel()
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tabView = UITableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 60 - 49), style: .plain)
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
        self.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        
        /// tableView
        viewModel.initData()
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.view.addSubview(tableView)
        self.tableView.register(PayoutTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        viewModel.payoutsArrayRx
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PayoutTableViewCell.self)) { (row, element, cell) in
                cell.itemNoLabel.text = "\(row)"
                cell.paidOnLabel.text = element.dateTime
                cell.amountLabel.text = String(element.amount! / 1000000)
            }.addDisposableTo(disposeBag)
        
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                return self?.viewModel.getTxData(index: indexPath.row).drive(onNext:{
                    let cell = self?.tableView.cellForRow(at: indexPath) as? PayoutTableViewCell
                    cell?.setSelected(false, animated: true)
                    let txArray = $0 as [TxModel]
                    self?.showPopupView(title: "Message", message: txArray[0].recipient!)
                }).addDisposableTo((self?.disposeBag)!)
            }).addDisposableTo(disposeBag)
        
    }
    
    func initData() {
        
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


extension PayoutETHViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let workerHeaderView = PayoutTableViewHeader.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        return workerHeaderView
    }
}







