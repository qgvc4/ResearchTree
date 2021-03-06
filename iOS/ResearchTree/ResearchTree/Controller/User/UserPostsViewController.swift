//
//  UserPostsViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/18/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class UserPostsViewController: UIViewController {

    var userToken: String?
    var user: User?
    var userPosts: [Feed] = []
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestFeeds), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var userPostsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.userPostsTableView.rowHeight = 150
        self.userPostsTableView.refreshControl = refresher
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if user != nil && userToken != nil {
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
                    self.userPosts.removeAll()
                    for feed in feeds {
                        if feed.peopleId == self.user!.id {
                            self.userPosts.append(feed.mapToFeed(rawFeed: feed))
                        }
                    }
                    for post in self.userPosts {
                        print(post.title)
                    }
                    self.userPosts.sort(by: {
                        $0.modifyTime > $1.modifyTime
                    })
                    self.userPostsTableView.reloadData()
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

extension UserPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        
        
        UserService.getUser(userToken: self.userToken!, userId: userPosts[indexPath.row].peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user, let cell = cell as? FeedTableViewCell {
                    self.user = user
                    cell.user.text = "\(user.firstname) \(user.lastname)"
                    cell.userImage.image = self.base64ToImage(base64: user.image)
                    cell.title.text = self.userPosts[indexPath.row].title
                    cell.time.text = dateFormatter.string(from: self.userPosts[indexPath.row].modifyTime)
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedDetailSegue2",
            let destination = segue.destination as? FeedDetailViewController,
            let row = userPostsTableView.indexPathForSelectedRow?.row {
            destination.userToken = self.userToken
            destination.feed = userPosts[row]
            userPostsTableView.deselectRow(at: userPostsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
