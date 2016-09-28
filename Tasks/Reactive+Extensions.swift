//
//  Reactive+Extensions.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/10/01.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    
    public var textColor: AnyObserver<UIColor> {
        return UIBindingObserver(UIElement: self.base) { label, color in
            label.textColor = color
            }.asObserver()
    }
    
}
