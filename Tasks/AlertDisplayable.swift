//
//  AlertDisplayable.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit

protocol AlertDisplayable {

    var showMessage: ((String) -> ()) { get }

}

extension AlertDisplayable where Self: UIViewController {

    var showMessage: ((String) -> ()) {
        return {
            [weak self] message in
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self?.present(alertController, animated: true, completion: nil)
        }
    }

}
