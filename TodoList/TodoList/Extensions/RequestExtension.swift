//
//  RequestExtension.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/9/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("=======================================")
        debugPrint(self)
        debugPrint("=======================================")
        #endif
        return self
    }
}
