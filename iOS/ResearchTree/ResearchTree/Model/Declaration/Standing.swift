//
//  Standing.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/27/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import Foundation

enum Standing: Int, CaseIterable {
    case Undergraduate = 0
    case Graduate
    case Professor
}

struct StandingMap {
    static func getString(standing: Standing) -> String {
        switch standing {
        case .Professor:
            return "Professor"
        case .Undergraduate:
            return "Undergraduate"
        case .Graduate:
            return "Graduate"
        }
    }
}
