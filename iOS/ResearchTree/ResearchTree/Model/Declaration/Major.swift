//
//  Major.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/27/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import Foundation

enum Major: Int, CaseIterable {
    case ComputerEngineer
    case ComputerScience
    case ElectricalEngineer
    case InformationTechnology
}

struct MajorMap {
    static func getString(major: Major) -> String {
        switch major {
        case .ComputerEngineer:
            return "Computer Engineer"
        case .ComputerScience:
            return "Computer Science"
        case .ElectricalEngineer:
            return "Electrical Engineer"
        case .InformationTechnology:
            return "Information Technology"
        }
    }
}
