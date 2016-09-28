//
// Created by 和泉田 領一 on 2016/09/29.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import RealmSwift

class Project: Object {

    dynamic var name = ""

    let tasks = List<Task>()

}

extension Project {

    static func create(name: String) throws -> Project {
        let realm   = try Realm()
        let project = Project()
        project.name = name

        try realm.write {
            realm.add(project)
        }

        return project
    }
    
    static func delete(project: Project) throws -> Project {
        let realm = project.realm
        try realm?.write {
            realm?.delete(project.tasks)
            realm?.delete(project)
        }
        return project
    }

}
