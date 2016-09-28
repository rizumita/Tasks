//
//  TaskCell.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import RxSwift

class TaskCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
}
