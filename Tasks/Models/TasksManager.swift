//
//  TasksManager.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import Foundation
import RealmSwift

struct TasksManager {

    static func fetch(in project: Project) -> [Task] {
        return Array(project.tasks)
    }

}
