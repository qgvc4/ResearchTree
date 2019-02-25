//
//  MyPostViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/12/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class MyPostsViewController: UIViewController {

    var myPosts: [Feed] = []
    var userToken: String?
    var userId: String?
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestFeeds), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var myPostsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.myPostsTableView.rowHeight = 150
        self.myPostsTableView.refreshControl = refresher
        
        
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
            requestFeeds()
        }
    }
    
    @objc
    func requestFeeds() {
        if (self.userToken == nil) {
            return
        }
        
        FeedService.getFeeds(userToken: self.userToken!, dispatchQueueForHandler: DispatchQueue.main) {
            (feeds, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let feeds = feeds {
                    self.myPosts.removeAll()
                    for feed in feeds {
                        if feed.peopleId == self.userId {
                            self.myPosts.append(feed.mapToFeed(rawFeed: feed))
                        }
                    }
                    self.myPosts.sort(by: {
                        $0.modifyTime > $1.modifyTime
                    })
                    self.myPostsTableView.reloadData()
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

extension MyPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        
        
        UserService.getUser(userToken: self.userToken!, userId: myPosts[indexPath.row].peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user, let cell = cell as? FeedTableViewCell {
                    cell.user.text = "\(user.firstname) \(user.lastname)"
                    cell.userImage.image = self.base64ToImage(base64: user.image)
                    cell.title.text = self.myPosts[indexPath.row].title
                    cell.time.text = dateFormatter.string(from: self.myPosts[indexPath.row].modifyTime)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FeedService.deleteFeed(userToken: self.userToken!, feedId: myPosts[indexPath.row].id, dispatchQueueForHandler: DispatchQueue.main) {
                (feed, errorString) in
                if errorString != nil {
                    self.displayAlert(message: errorString!)
                } else {
                    self.myPosts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .bottom)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myPostDetailSegue",
            let destination = segue.destination as? MyPostDetailViewController,
            let row = myPostsTableView.indexPathForSelectedRow?.row {
            destination.userToken = self.userToken
            destination.myPost = myPosts[row]
            myPostsTableView.deselectRow(at: myPostsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
