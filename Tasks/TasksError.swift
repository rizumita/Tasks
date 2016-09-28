//
//  TasksError.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import Foundation

enum TasksError: Error {

    case invalidProjectName
    case invalidTaskName
    case unknown

    static func toMessage(error: Error) -> String {
        guard let error = error as? TasksError else {
            return "Unknown error"
        }

        switch error {
        case .invalidProjectName:
            return "Invalid project name"
        case .invalidTaskName:
            return "Invalid task name"
        case .unknown:
            return "Unknown error"
        }
    }
}
