//
//  JobService.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/5/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import Foundation
class JobService {
    static let jobUrlString = ApiConstant.baseUrl + "Jobs"

    class func getJob(userToken: String, jobId: String, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawJob?, String?) -> Void) {
        var job: RawJob? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "\(jobUrlString)/\(jobId)") else {
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
                var errorString = "data not available for get job"
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
                job = try decoder.decode(RawJob.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(job, nil)
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
    
    class func getJobs(userToken: String, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping ([RawJob]?, String?) -> Void) {
        var jobs: [RawJob]? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: jobUrlString) else {
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
                var errorString = "data not available for get jobs"
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
                jobs = try decoder.decode([RawJob].self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(jobs, nil)
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
    
    class func postJob(userToken: String, postJobRequest: PostPutJobRequest, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawJob?, String?) -> Void) {
        var job: RawJob? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: jobUrlString) else {
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
            let data = try encoder.encode(postJobRequest)
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
                var errorString = "data for post job"
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
                job = try decoder.decode(RawJob.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(job, nil)
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
    
    class func updateJob(userToken: String, jobId: String, putJobRequest: PostPutJobRequest, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawJob?, String?) -> Void) {
        var job: RawJob? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "\(jobUrlString)/\(jobId)") else {
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
            let data = try encoder.encode(putJobRequest)
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
                var errorString = "data for put job"
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
                job = try decoder.decode(RawJob.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(job, nil)
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
    
    class func deleteJob(userToken: String, jobId: String, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (RawJob?, String?) -> Void) {
        var job: RawJob? = nil
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "\(jobUrlString)/\(jobId)") else {
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
                var errorString = "data for post job"
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
                job = try decoder.decode(RawJob.self, from: data)
                dispatchQueueForHandler.async(execute: {
                    completionHandler(job, nil)
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
