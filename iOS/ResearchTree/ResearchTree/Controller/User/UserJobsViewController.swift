//
//  UserJobsViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/18/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class UserJobsViewController: UIViewController {

    var userToken: String?
    var user: User?
    
    var userJobs: [Job] = []
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestJobs), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var jobsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.jobsTableView.rowHeight = 150
        self.jobsTableView.refreshControl = refresher
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if user != nil && userToken != nil {
            refresher.beginRefreshing()
            requestJobs()
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
                    self.userJobs.removeAll()
                    for job in jobs {
                        if job.peopleId == self.user!.id {
                            self.userJobs.append(job.mapToJob(rawJob: job))
                        }
                    }
                    self.userJobs.sort(by: {
                        $0.modifyTime > $1.modifyTime
                    })
                    self.jobsTableView.reloadData()
                    self.refresher.endRefreshing()
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
    
    func base64ToImage(base64: String?) -> UIImage {
        if base64 == nil {
            return UIImage(named: "DefaultProfile")!
        }
        let data = Data(base64Encoded: base64!, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        
        if let data = data {
            if let imageTemp = UIImage(data: data) {
                return imageTemp
            }
        }
        
        return UIImage(named: "DefaultProfile")!
    }
}

extension UserJobsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        
        
        UserService.getUser(userToken: self.userToken!, userId: userJobs[indexPath.row].peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user, let cell = cell as? JobTableViewCell {
                    self.user = user 
                    let curJob = self.userJobs[indexPath.row]
                    cell.userImageView.image = self.base64ToImage(base64: user.image)
                    cell.contactEmail.text = user.email
                    cell.title.text = curJob.title
                    cell.jorDescription.text = curJob.description
                    if curJob.payment {
                        cell.paymentImageView.image = UIImage(named: "money")!
                    } else {
                        cell.paymentImageView.image = nil
                    }
                    
                    cell.time.text = dateFormatter.string(from: curJob.modifyTime)
                    
                    //standing
                    cell.standing.text = StandingMap.getString(standing: curJob.standing)
                    
                    //major
                    var majorString = ""
                    for major in curJob.majors {
                        majorString += MajorMap.getString(major: major)
                        majorString += "\n"
                    }
                    cell.majors.text = majorString
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jobDetailSegue2",
            let destination = segue.destination as? JobDetailViewController,
            let row = jobsTableView.indexPathForSelectedRow?.row {
            destination.userToken = self.userToken
            destination.job = userJobs[row]
            jobsTableView.deselectRow(at: jobsTableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
}

