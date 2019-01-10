//
//  FeedService.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/9/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import Foundation

class FeedService {
    static let feedUrlString = ApiConstant.baseUrl + "Feeds"
    
    class func getFeeds(userToken: String, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping ([Feed]?, String?) -> Void) {
        var feeds: [Feed]? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: feedUrlString) else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(nil, "the url is invalid")
            })
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                var errorString = "data not available for get feeds"
                if let error = error {
                    errorString = error.localizedDescription
                }
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                let errorString = "401 unauthorization error"
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 500 {
                let errorString = "server is down"
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }
            
            let decoder = JSONDecoder()
            do {
                feeds = try decoder.decode([Feed].self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(feeds, nil)
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
