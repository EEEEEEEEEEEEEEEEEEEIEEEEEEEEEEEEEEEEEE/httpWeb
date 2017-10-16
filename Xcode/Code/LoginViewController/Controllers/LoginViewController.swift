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
import MBProgressHUD

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    var HUD:MBProgressHUD?
    
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
        self.view.backgroundColor = CommonSceneColor()
        userNameTextField.text = "hxI"
        passwordTextField.text = "i12345"
        
        viewModel = LoginViewModel(input: (username: userNameTextField.rx.text.orEmpty.asDriver(),
                                           password: passwordTextField.rx.text.orEmpty.asDriver(),
                                           loginTaps: loginButton.rx.tap.asDriver()))
        
        // 登陆按键使能
        viewModel.loginButtonEnabled
            .drive(onNext: { [unowned self] valid in
                self.loginButton.isEnabled = valid
                self.loginButton.alpha = valid ? 1 : 0.5
            }).addDisposableTo(disposeBag)
        
        // 登陆点击事件
        (loginButton.rx.tap).subscribe(onNext: {
            self.showHUD(message: "Loading...")
        }).addDisposableTo(disposeBag)
        
        // 登陆返回
        viewModel.loginResult.drive(onNext: { result in
            switch result {
            case .success:
                print("成功")
                self.hiddenHUD()
                self.dismiss(animated: true, completion: nil)
            case .empty:
                print("空")
            case .failed:
                print("失败")
            }
        }).addDisposableTo(disposeBag)
        
        
        
        // 注册点击事件
        (RegisterButton.rx.tap).subscribe(onNext: {
            let registerViewController = RegisterViewController()
            self.present(registerViewController, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
    }
}




/* HUD */
extension LoginViewController {
    
    func showHUD(message: String) {
        
        if HUD != nil {
            return
        }
        
        HUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        HUD?.bezelView.color = UIColor.black
        HUD?.contentColor = UIColor.white
        HUD?.label.text = message
        HUD?.removeFromSuperViewOnHide = true
        HUD?.hide(animated: true, afterDelay: 20)
        HUD?.backgroundView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        HUD?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hiddenHUD)))
    }
    
    func hiddenHUD() {
        if HUD != nil {
            HUD?.removeFromSuperview()
            HUD = nil
        }
    }
}




