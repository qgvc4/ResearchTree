//
//  JobViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/5/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class JobViewController: UIViewController {

    var jobs: [Job] = []
    var userToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (isUserLoggedIn) {
            let userData = UserDefaults.standard.data(forKey: "userData")
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData!)
                self.userToken = user.token
            } catch {
                print("decode error")
                return
            }
            
           // refresher.beginRefreshing()
            requestJobs()
            for job in jobs {
                print(job.title)
            }
        }
    }
    
    @objc
    func requestJobs() {
        if (self.userToken == nil) {
            return
        }
        
        JobService.getJobs(userToken: self.userToken!, dispatchQueueForHandler: DispatchQueue.main) {
            (jobs, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let jobs = jobs {
                    self.jobs.removeAll()
                    for job in jobs {
                        self.jobs.append(job.mapToJob(rawJob: job))
                    }
                    self.jobs.sort(by: {
                        $0.modifyTime > $1.modifyTime
                    })
//                    self.feedsTableView.reloadData()
//                    self.refresher.endRefreshing()
                }
            }
        }
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
