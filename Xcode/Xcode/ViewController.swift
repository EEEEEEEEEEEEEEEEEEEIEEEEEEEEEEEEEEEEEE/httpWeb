//
//  ViewController.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/6.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testButton = UIButton(type: UIButtonType.custom)
        testButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testButton.backgroundColor = UIColor.darkGray
        testButton.addTarget(self, action: #selector(testButtonAction), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testButtonAction() {
        print("123")
    }
}

