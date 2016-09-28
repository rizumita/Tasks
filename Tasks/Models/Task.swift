//
// Created by 和泉田 領一 on 2016/09/29.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {

    dynamic var title     = ""
    dynamic var completed = false

    let project = LinkingObjects(fromType: Project.self, property: "tasks")

}

extension Task {

    static func create(title: String, in project: Project) throws -> Task {
        let realm = try Realm()
        let task  = Task()
        task.title = title
        
        try realm.write {
            project.tasks.append(task)
            realm.add(task)
        }
        
        return task
    }

    static func delete(task: Task) throws -> Project {
        guard let realm = task.realm, let project = task.project.first, let index = project.tasks.index(of: task) else {
            throw TasksError.unknown
        }

        try realm.write {
            project.tasks.remove(objectAtIndex: index)
            realm.delete(task)
        }

        return project
    }

    static func set(title: String, to task: Task) throws -> Task {
        try task.realm?.write {
            task.title = title
        }
        return task
    }

    static func set(completed: Bool, to task: Task) throws -> Task {
        try task.realm?.write {
            task.completed = completed
        }
        return task
    }

}
