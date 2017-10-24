//
//  BaseViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/8.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController, MBProgressHUDDelegate {

    var HUD: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


/* HUD */
extension BaseViewController {
    
    func showHUD(message: String) {
        
        if HUD != nil {
            return
        }
        
        HUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        HUD?.bezelView.color = UIColor.black
        HUD?.contentColor = UIColor.white
        HUD?.label.text = message
        HUD?.delegate = self
        HUD?.removeFromSuperViewOnHide = true
        HUD?.hide(animated: true, afterDelay: 20)
        HUD?.backgroundView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        HUD?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hiddenHUD)))
    }
    
    func hiddenHUD() {
        HUD?.hide(animated: true)
    }
    
    func changeHUDMessage(message: String, showTime: Double) {
        HUD?.mode = .text
        HUD?.hide(animated: true, afterDelay: showTime)
        HUD?.label.text = message
    }
    
    public func hudWasHidden(_ hud: MBProgressHUD) {
        
        guard hud == HUD else {
            return
        }
        
        print("自动退出")
        if HUD != nil {
            HUD?.removeFromSuperview()
            HUD = nil
        }
    }
}
