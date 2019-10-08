//
//  UserModel.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/7/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TaskModel {
    let id: Int
    
    let title: String
    
    let dueBy: Int
    
    let priority: String

    init(json_resp : JSON) {
        self.id = json_resp["id"].int!
        self.title = json_resp["title"].string!
        self.dueBy = json_resp["dueBy"].int!
        self.priority = json_resp["priority"].string!
    }
}
