//
//  RxSwift.swift
//  Xcode
//
//  Created by Hanxun on 2017/9/8.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    var validationResult: UIBindingObserver<Base, EnumResult> {
        return UIBindingObserver(UIElement: base) { label, result in
            label.textColor = result.textColor
            //label.text = result.description
        }
    }
}


extension Reactive where Base: UILabel {
    var tapEnabled: UIBindingObserver<Base, EnumResult> {
        return UIBindingObserver(UIElement: base) { button, result in
            button.isEnabled = result.isValid
        }
    }
}

extension Reactive where Base: UIView {
    var backgroundColor: UIBindingObserver<Base, EnumResult> {
        return UIBindingObserver(UIElement: base) { view, result in
            view.backgroundColor = result.backgroundColor
        }
    }
}
