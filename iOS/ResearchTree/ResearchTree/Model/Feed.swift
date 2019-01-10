//
//  Feed.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/9/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import Foundation

struct Feed: Codable {
    var id: String
    var peopleId: String
    var title: String
    var description: String
    var modifyTime: String
    var attachment: String?
}

struct postFeedRequest: Codable {
    var title: String
    var peopleId: String
    var description: String
    var attachment: String?
}
