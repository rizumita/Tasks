//
// Created by 和泉田 領一 on 2016/09/30.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swiftz

struct EditingTask {

    let title: String
    let completed: Bool

}

extension EditingTask {

    static func set(title: String, to task: EditingTask) -> EditingTask {
        return EditingTask(title: title, completed: task.completed)
    }

    static func set(completed: Bool, to task: EditingTask) -> EditingTask {
        return EditingTask(title: task.title, completed: completed)
    }
    
    static func update(task: Task, by editingTask: EditingTask) throws -> Task {
        let titleTask = try Task.set(title: editingTask.title, to: task)
        let result = try Task.set(completed: editingTask.completed, to: titleTask)
        return result
    }

}

extension EditingTask: Equatable {

    static func ==(lhs: EditingTask, rhs: EditingTask) -> Bool {
        return lhs.title == rhs.title && lhs.completed == rhs.completed
    }

}
