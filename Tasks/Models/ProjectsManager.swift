//
// Created by 和泉田 領一 on 2016/09/29.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import RealmSwift

struct ProjectsManager {

    static func fetch() throws -> [Project] {
        let realm = try Realm()
        return Array(realm.objects(Project.self))
    }

}
