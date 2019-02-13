//
//  MyPostDetailViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/12/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class MyPostDetailViewController: UIViewController {

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var myPost: Feed?
    var userToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showPostDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FeedService.getFeed(userToken: self.userToken!, feedId: myPost!.id, dispatchQueueForHandler: DispatchQueue.main) {
            (feed, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let feed = feed {
                    self.myPost = feed.mapToFeed(rawFeed: feed)
                    self.showPostDetail()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPostSegue",
            let destination = segue.destination as? EditMyPostViewController {
            destination.userToken = self.userToken
            destination.myPost = self.myPost
        }
    }
    
    func showPostDetail() {
        if myPost == nil {
            return
        }
        
        postTitle.text = myPost!.title
        postDescription.text = myPost!.description
        if let data = myPost!.attachment, let image = UIImage(data: data) {
            postImageView.image = image
        }
        
        UserService.getUser(userToken: self.userToken!, userId: myPost!.peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user {
                    self.username.text = "\(user.firstname) \(user.lastname)"
                    self.userImageView.image = self.base64ToImage(base64: user.image)
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
