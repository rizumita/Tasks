//
//  Variable+Extensions.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import Foundation
import RxSwift

extension Variable {
    
    func get() -> Element {
        return value
    }
    
}

extension Variable where Element: Collection, Element.Index == Int {
    
    func item(at indexPath: IndexPath) -> Element.Iterator.Element {
        return value[indexPath.row]
    }
    
}

