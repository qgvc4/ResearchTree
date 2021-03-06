//
//  MyJobsViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/18/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class MyJobsViewController: UIViewController {

    var myJobs: [Job] = []
    var userToken: String?
    var userId: String?
    
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
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (isUserLoggedIn) {
            let userData = UserDefaults.standard.data(forKey: "userData")
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData!)
                self.userToken = user.token
                self.userId = user.id
            } catch {
                print("decode error")
                return
            }
            
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
                    self.myJobs.removeAll()
                    for job in jobs {
                        if job.peopleId == self.userId {
                            self.myJobs.append(job.mapToJob(rawJob: job))
                        }
                    }
                    self.myJobs.sort(by: {
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

extension MyJobsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        
        
        UserService.getUser(userToken: self.userToken!, userId: myJobs[indexPath.row].peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user, let cell = cell as? JobTableViewCell {
                    let curJob = self.myJobs[indexPath.row]
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            JobService.deleteJob(userToken: self.userToken!, jobId: myJobs[indexPath.row].id, dispatchQueueForHandler: DispatchQueue.main) {
                (feed, errorString) in
                if errorString != nil {
                    self.displayAlert(message: errorString!)
                } else {
                    self.myJobs.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .bottom)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myJobsDetailSegue",
            let destination = segue.destination as? MyJobsDetailViewController,
            let row = jobsTableView.indexPathForSelectedRow?.row {
            destination.userToken = self.userToken
            destination.job = myJobs[row]
            jobsTableView.deselectRow(at: jobsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
