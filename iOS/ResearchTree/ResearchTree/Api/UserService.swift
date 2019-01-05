//
//  UserService.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/27/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import Foundation

class UserService {
    static let signUpUrlString = ApiConstant.baseUrl + "Account"
    static let loginUrlString = ApiConstant.baseUrl + "Account/Login"
    
    class func SignUp(user: User) {
        
    }
    
    class func LogIn(userCredential: UserLoginRequest, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (User?, String?) -> Void) {
        var user: User? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: loginUrlString) else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(nil, "the url is invalid")
            })
            return
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(userCredential)
            urlRequest.httpBody = data
        } catch {
            print("encode error")
            let errorString = "Something went wrong"
            dispatchQueueForHandler.async(execute: {
                completionHandler(nil, errorString)
            })
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                var errorString = "data not available for login"
                if let error = error {
                    errorString = error.localizedDescription
                }
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 400 {
                let errorString = "invalid password or email"
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }
            
            let decoder = JSONDecoder()
            do {
                user = try decoder.decode(User.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(user, nil)
                })
            } catch {
                print("decode error")
                let errorString = "Something went wrong"
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
            }
        }
        task.resume()
    }
}
