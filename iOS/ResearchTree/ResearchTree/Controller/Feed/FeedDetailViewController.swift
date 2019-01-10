//
//  FeedDetailViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/13/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {

    @IBOutlet weak var feedTitle: UILabel!
    var feed: Feed?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let feed = feed {
            feedTitle.text = "id: \(feed.id) title: \(feed.title) discription: \(feed.description)"
        }
        // Do any additional setup after loading the view.
    }
}
