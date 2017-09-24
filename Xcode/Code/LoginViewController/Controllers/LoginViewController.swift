//
//  LoginViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/8.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    
    
    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initData()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initData() {
        
    }
    
    func initView() {
//        let image = UIImage.init(named: "LoginBack")
//        self.view.layer.contents = image?.cgImage
        self.view.backgroundColor = CommonBackgroundColor()
        viewModel = LoginViewModel(input: (username: userNameTextField.rx.text.orEmpty.asDriver(),
                                           password: passwordTextField.rx.text.orEmpty.asDriver(),
                                           loginTaps: loginButton.rx.tap.asDriver()))
        
        viewModel.loginButtonEnabled
            .drive(onNext: { [unowned self] valid in
                self.loginButton.isEnabled = valid
                self.loginButton.alpha = valid ? 1 : 0.5
            }).addDisposableTo(disposeBag)
        
        viewModel.loginResult.drive(onNext: { result in
            switch result {
            case let .success(message):
                print("\(message)")
            case .empty:
                print("空")
            case let .failed(message):
                print("\(message)")
            }
        }).addDisposableTo(disposeBag)
        
        (RegisterButton.rx.tap).subscribe(onNext: {
            let registerViewController = RegisterViewController()
            self.present(registerViewController, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
    }
}






