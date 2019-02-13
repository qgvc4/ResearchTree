//
//  Feed.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/9/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import Foundation

struct RawFeed: Codable {
    var id: String
    var peopleId: String
    var title: String
    var description: String
    var modifyTime: String
    var attachment: String?
    
    func mapToFeed(rawFeed: RawFeed) -> Feed {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let modifyTime = dateFormatter.date(from: rawFeed.modifyTime)!
        var attachment: Data? = nil
        if let rawAttachment = rawFeed.attachment {
            attachment = Data(base64Encoded: rawAttachment, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        }
        
        let feed = Feed.init(id: rawFeed.id, peopleId: rawFeed.peopleId, title: rawFeed.title, description: rawFeed.description, modifyTime: modifyTime, attachment: attachment)
        return feed
    }
}

struct Feed {
    var id: String
    var peopleId: String
    var title: String
    var description: String
    var modifyTime: Date
    var attachment: Data?
}

struct PostPutFeedRequest: Codable {
    var title: String
    var peopleId: String
    var description: String
    var attachment: String?
}

