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
    @IBOutlet weak var feedsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        var userToken: String
        
        if (isUserLoggedIn) {
            let userData = UserDefaults.standard.data(forKey: "userData")
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData!)
                userToken = user.token
            } catch {
                print("decode error")
                return
            }
            
            FeedService.getFeeds(userToken: userToken, dispatchQueueForHandler: DispatchQueue.main) {
                (feeds, errorString) in
                if errorString != nil {
                    self.displayAlert(message: errorString!)
                } else {
                    if let feeds = feeds {
                        self.feeds = feeds
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
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        
        if let cell = cell as? FeedTableViewCell {
            cell.title.text = feeds[indexPath.row].title
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedDetailSegue",
            let destination = segue.destination as? FeedDetailViewController,
            let row = feedsTableView.indexPathForSelectedRow?.row {
                destination.feed = feeds[row]
                feedsTableView.deselectRow(at: feedsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
