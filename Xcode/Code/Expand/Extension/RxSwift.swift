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


infix operator <->

@discardableResult func <-><T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
        .bind(to: property)
    
    let propertyToVariable = property
        .subscribe(
            onNext: { variable.value = $0 },
            onCompleted: { variableToProperty.dispose() }
    )
    
    return Disposables.create(variableToProperty, propertyToVariable)
}


@discardableResult func <-><T: Comparable>(left: Variable<T>, right: Variable<T>) -> Disposable {
    let leftToRight = left.asObservable()
        .distinctUntilChanged()
        .bind(to: right)
    
    let rightToLeft = right.asObservable()
        .distinctUntilChanged()
        .bind(to: left)
    
//    return StableCompositeDisposable.create(leftToRight, rightToLeft)
    return Disposables.create(leftToRight, rightToLeft)
}









