//
//  User.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/27/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import Foundation

struct UserLoginRequest: Codable {
    var email: String
    var password: String
}

struct UserSignUpRequest: Codable {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var majors: [Int]
    var image: String?
    var role: Int
    var standing: Int
    var location: String
    var description: String?
    var resume: String?
}

struct User: Codable {
    var id: String
    var email: String
    var password: String?
    var token: String?
    var firstname: String
    var lastname: String
    var majors: [Int]
    var image: String?
    var role: Int
    var standing: Int
    var location: String?
    var description: String?
    var resume: String?
}

struct SignUpError: Codable {
    var code: String
    var description: String
}
