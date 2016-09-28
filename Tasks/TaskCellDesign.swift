//
//  TaskCellDesign.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/30.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit

struct TaskCellDesign {
    
    static func textColor(for completed: Bool) -> UIColor {
        return completed ? .lightGray : .black
    }
    
}
