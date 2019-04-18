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
    var filteredJobs: [Job] = []
    var userToken: String?
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchActive : Bool = false
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
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
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        //jobsTableView.tableHeaderView = searchController.searchBar
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchBar.placeholder = "Search for Jobs"
        searchController.searchBar.sizeToFit()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (isUserLoggedIn) {
            let userData = UserDefaults.standard.data(forKey: "userData")
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData!)
                self.userToken = user.token
                if user.role == Role.Professor.rawValue {
                    addButton.isEnabled = true
                } else {
                    addButton.isEnabled = false
                }
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
                    self.jobs.removeAll()
                    self.filteredJobs.removeAll()
                    for job in jobs {
                        self.jobs.append(job.mapToJob(rawJob: job))
                        self.filteredJobs.append(job.mapToJob(rawJob: job))
                    }
                    self.jobs.sort(by: {
                        $0.modifyTime > $1.modifyTime
                    })
                    self.filteredJobs.sort(by: {
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

extension JobViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        
        
        UserService.getUser(userToken: self.userToken!, userId: filteredJobs[indexPath.row].peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if indexPath.row > self.filteredJobs.count - 1 {
                return
            }
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user, let cell = cell as? JobTableViewCell {
                    let curJob = self.filteredJobs[indexPath.row]
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
        if segue.identifier == "jobDetailSegue",
            let destination = segue.destination as? JobDetailViewController,
            let row = jobsTableView.indexPathForSelectedRow?.row {
            destination.userToken = self.userToken
            destination.job = filteredJobs[row]
            jobsTableView.deselectRow(at: jobsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
}

extension JobViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredJobs = jobs
        } else {
            filteredJobs = jobs.filter {
                if $0.title.lowercased().contains(searchController.searchBar.text!.lowercased())
                    || $0.description.lowercased().contains(searchController.searchBar.text!.lowercased())
                    || $0.location.lowercased().contains(searchController.searchBar.text!.lowercased())
                    || self.toMajorsString(majors: $0.majors).lowercased().contains(searchController.searchBar.text!.lowercased()) {
                    return true
                }
                return false
            }
        }
        
        self.jobsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
        searchController.searchBar.text = ""
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.jobsTableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.jobsTableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            self.jobsTableView.reloadData()
        }
        
        self.searchController.searchBar.resignFirstResponder()
    }
    
    func toMajorsString(majors: [Major]) -> String {
        var majorsString = ""
        for major in majors {
            majorsString += MajorMap.getString(major: major)
        }
        return majorsString
    }
}
