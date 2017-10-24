//
//  EditWorkerInfoViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/10/23.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditWorkerInfoViewController: BaseViewController {

    let disposeBag = DisposeBag()
    var editWorkerInfoViewModel = EditWorkerInfoViewModel()
    @IBOutlet weak var workerIdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initView() {
        
        /* 导航栏 */
        let navBarView = NavBarView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        navBarView.titleLabel.text = "Add Worker Info"
        navBarView.leftButton.setTitle("Cancel", for: .normal)
        navBarView.leftButton.titleLabel?.font = CommonFont16()
        navBarView.leftButton.layer.borderWidth = 0
        navBarView.leftViceButton.setTitle("", for: .normal)
        navBarView.leftViceButton.layer.borderWidth = 0
        navBarView.rightButton.setTitle("Save", for: .normal)
        self.view.addSubview(navBarView)
        
        
        /* 取消事件 */
        navBarView.leftButton.rx.tap.subscribe(onNext: { (value) in
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        
        /* 保存事件 发送请求并显示菊花 */
        navBarView.rightButton.rx.tap.subscribe(onNext: { (value) in
            self.editWorkerInfoViewModel.saveDataHandle()
            self.showHUD(message: "添加中...")
        }).addDisposableTo(disposeBag)
        
        /* 返回保存结束时的处理，关闭菊花 */
        editWorkerInfoViewModel.requestChangeWokersResult.asObservable().skip(1)
            .subscribe(onNext: { (result) in
                guard (result.ResultId != nil) && (result.Message != nil) else {
                    return
                }
                
                self.changeHUDMessage(message: "\(result.Message!)", showTime: 2)
//                self.hiddenHUD()
                
//                if !(result.Message?.contains("Add"))! {
//                    return
//                }
//                print("++++ \(result.ResultId!) - \(result.Message!)")
        }).addDisposableTo(disposeBag)
        
        //  0 Add success : 1
        // 99 Wrong password
        
        // 双向绑定 参考：https://stackoverflow.com/questions/37496074/two-way-binding-in-rxswift
        (workerIdTextField.rx.text <-> editWorkerInfoViewModel.workerId).addDisposableTo(disposeBag)
    }
}






