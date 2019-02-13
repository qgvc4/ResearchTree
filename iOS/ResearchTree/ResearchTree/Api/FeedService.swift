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
    
    class func getFeed(userToken: String, feedId: String, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawFeed?, String?) -> Void) {
        var feed: RawFeed? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "\(feedUrlString)/\(feedId)") else {
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
                var errorString = "data not available for get feed"
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
                feed = try decoder.decode(RawFeed.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(feed, nil)
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
    
    class func getFeeds(userToken: String, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping ([RawFeed]?, String?) -> Void) {
        var feeds: [RawFeed]? = nil
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
                feeds = try decoder.decode([RawFeed].self, from: data)
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
    
    class func postFeed(userToken: String, postFeedRequest: PostPutFeedRequest, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawFeed?, String?) -> Void) {
        var feed: RawFeed? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        guard let url = URL(string: feedUrlString) else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(nil, "the url is invalid")
            })
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"

        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(postFeedRequest)
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
                var errorString = "data for post feed"
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
                let errorString = "Something went wrong"
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }

            let decoder = JSONDecoder()
            do {
                feed = try decoder.decode(RawFeed.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(feed, nil)
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
    
    class func updateFeed(userToken: String, feedId: String, putFeedRequest: PostPutFeedRequest, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawFeed?, String?) -> Void) {
        var feed: RawFeed? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "\(feedUrlString)/\(feedId)") else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(nil, "the url is invalid")
            })
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(putFeedRequest)
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
                var errorString = "data for put feed"
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
                let errorString = "Something went wrong"
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }
            
            let decoder = JSONDecoder()
            do {
                feed = try decoder.decode(RawFeed.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(feed, nil)
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
    
    class func deleteFeed(userToken: String, feedId: String, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawFeed?, String?) -> Void) {
        var feed: RawFeed? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "\(feedUrlString)/\(feedId)") else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(nil, "the url is invalid")
            })
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "DELETE"
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                var errorString = "data for post feed"
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
                let errorString = "Something went wrong"
                dispatchQueueForHandler.async(execute: {
                    completionHandler(nil, errorString)
                })
                return
            }
            
            let decoder = JSONDecoder()
            do {
                feed = try decoder.decode(RawFeed.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(feed, nil)
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
