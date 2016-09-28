//
// Created by 和泉田 領一 on 2016/09/30.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation

struct TaskTranslator {

    static func translate(task: Task) -> EditingTask {
        return EditingTask(title: task.title, completed: task.completed)
    }

}
