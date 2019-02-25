//
//  FeedDetailViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/24/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {


    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var feedDescription: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    
    var feed: Feed?
    var userToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        
        if feed == nil {
            return
        }
        
        feedTitle.text = feed!.title
        feedDescription.text = feed!.description
        if let data = feed!.attachment, let image = UIImage(data: data) {
            feedImage.image = image
        }
        
        UserService.getUser(userToken: self.userToken!, userId: feed!.peopleId, dispatchQueueForHandler: DispatchQueue.main) {
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
        
        // Do any additional setup after loading the view.
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
