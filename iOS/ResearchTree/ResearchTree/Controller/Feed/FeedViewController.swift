//
//  FeedViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/13/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    var feeds: [Feed] = []
    var userToken: String?
    @IBOutlet weak var feedsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.feedsTableView.rowHeight = 150
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
            
            FeedService.getFeeds(userToken: self.userToken!, dispatchQueueForHandler: DispatchQueue.main) {
                (feeds, errorString) in
                if errorString != nil {
                    self.displayAlert(message: errorString!)
                } else {
                    if let feeds = feeds {
                        self.feeds.removeAll()
                        for feed in feeds {
                            self.feeds.append(feed.mapToFeed(rawFeed: feed))
                        }
                        self.feeds.sort(by: {
                            $0.modifyTime > $1.modifyTime
                        })
                        self.feedsTableView.reloadData()
                    }
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

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        
        
        UserService.getUser(userToken: self.userToken!, userId: feeds[indexPath.row].peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user, let cell = cell as? FeedTableViewCell {
                    cell.user.text = "\(user.firstname) \(user.lastname)"
                    cell.userImage.image = self.base64ToImage(base64: user.image)
                    cell.title.text = self.feeds[indexPath.row].title
                    cell.time.text = dateFormatter.string(from: self.feeds[indexPath.row].modifyTime)
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedDetailSegue",
            let destination = segue.destination as? FeedDetailViewController,
            let row = feedsTableView.indexPathForSelectedRow?.row {
            destination.userToken = self.userToken
            destination.feed = feeds[row]
            feedsTableView.deselectRow(at: feedsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
