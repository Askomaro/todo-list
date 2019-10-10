//
//  MyTasksTVCProtocol.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/10/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import Foundation

protocol MyTasksTVCProtocol: class {
    func updateUI(sortOption : SortOptionEnum) -> Void
}
