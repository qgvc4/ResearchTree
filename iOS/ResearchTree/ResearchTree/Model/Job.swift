//
//  Job.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/5/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import Foundation

struct RawJob: Codable {
    var id: String
    var peopleId: String
    var title: String
    var description: String
    var standing: Int
    var payment: Bool
    var majors: [Int]
    var modifyTime: String
    var location: String
    
    func mapToJob(rawJob: RawJob) -> Job {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let modifyTime = dateFormatter.date(from: rawJob.modifyTime)!
        let standing = Standing.init(rawValue: rawJob.standing)!
        var majors: [Major] = []
        for major in rawJob.majors {
            majors.append(Major.init(rawValue: major)!)
        }
        let job = Job.init(id: rawJob.id, peopleId: rawJob.peopleId, title: rawJob.title, description: rawJob.description, standing: standing, payment: rawJob.payment, majors: majors, modifyTime: modifyTime, location: rawJob.location)
        
        return job
    }
}

struct Job {
    var id: String
    var peopleId: String
    var title: String
    var description: String
    var standing: Standing
    var payment: Bool
    var majors: [Major]
    var modifyTime: Date
    var location: String
}

struct postJobRequest: Codable {
    var title: String
    var peopleId: String
    var description: String
    var majors: [Int]
    var location: String
}
