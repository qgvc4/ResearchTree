//
//  UserDetailViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/30/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    var userToken: String?
    var user: User?
    let tableViewString = ["Posts", "Jobs"]
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var majors: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var postOrJobTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = user {
            username.text = "\(user.firstname) \(user.lastname)"
            role.text = StandingMap.getString(standing: Standing(rawValue: user.standing)!)
            email.text = user.email
            location.text = user.location
            var majorString = ""
            for major in user.majors {
                majorString += MajorMap.getString(major: Major(rawValue: major)!)
                majorString += "\n"
            }
            majors.text = majorString
            userImageView.image = base64ToImage(base64: user.image)
        }
        
        postOrJobTableView.separatorColor = UIColor.darkGray
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

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCell", for: indexPath)
        
        cell.textLabel?.text = tableViewString[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostOrJobSegue",
            let destination = segue.destination as? UserPostOrJobViewController,
            let row = postOrJobTableView.indexPathForSelectedRow?.row {
            destination.userToken = self.userToken
            destination.pageFlag = tableViewString[row]
            postOrJobTableView.deselectRow(at: postOrJobTableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}
