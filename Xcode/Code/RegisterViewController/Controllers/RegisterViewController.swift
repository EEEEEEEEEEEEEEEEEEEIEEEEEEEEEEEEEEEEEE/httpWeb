//
//  RegisterViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/11.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var aginPasswordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var usernameStatus: UIView!
    @IBOutlet weak var passwordStatus: UIView!
    @IBOutlet weak var aginPasswordStatus: UIView!
    @IBOutlet weak var phoneNumberStatus: UIView!
    
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    let disposeBag = DisposeBag()
    var registerViewModel: RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        
        self.view.backgroundColor = CommonBackgroundColor()
        
        registerViewModel = RegisterViewModel(input: (username: usernameTextField.rx.text.orEmpty.asObservable(),
                                                      password: passwordTextField.rx.text.orEmpty.asObservable(),
                                                      againPassword: aginPasswordTextField.rx.text.orEmpty.asObservable(),
                                                      phoneNumber: phoneNumberTextField.rx.text.orEmpty.asObservable()))
        
        registerViewModel.usernameCheck.bind(to: usernameStatus.rx.backgroundColor).addDisposableTo(disposeBag)
        
        
        
        (LoginButton.rx.tap).subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        
    }
    
    func initData() {
        
    }
    
    
}
