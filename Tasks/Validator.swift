//
//  Validator.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import Foundation

struct Validator {

    static func validate(name: String?) throws -> String {
        guard name?.isEmpty == false, let name = name else {
            throw TasksError.invalidProjectName
        }
        return name
    }

    static func validate(title: String?) -> String {
        guard title?.isEmpty == false, let title = title else {
            return "No Name"
        }
        return title
    }

}
