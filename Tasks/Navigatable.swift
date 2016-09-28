//
//  Navigatable.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/30.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit

protocol Navigatable {
    
    func pop(animated: Bool) -> () -> ()
    
}

extension Navigatable where Self: UIViewController {
    
    func pop(animated: Bool) -> () -> () {
        return {
            [weak self] in
            _ = self?.navigationController?.popViewController(animated: animated)
        }
    }
    
}
