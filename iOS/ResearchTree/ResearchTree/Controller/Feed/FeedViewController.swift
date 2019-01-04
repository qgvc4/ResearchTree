//
//  FeedViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/13/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    let feeds: [String] = ["Feed1", "Feed2"]
    @IBOutlet weak var feedsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        
        if let cell = cell as? FeedTableViewCell {
            cell.title.text = feeds[indexPath.row]
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
