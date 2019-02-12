//
//  SettingViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/28/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userMajors: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (isUserLoggedIn) {
            let userData = UserDefaults.standard.data(forKey: "userData")
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData!)
                username.text = "\(user.firstname) \(user.lastname)"
                userEmail.text = "\(user.email)"
                userDescription.text = "\(user.description ?? "")"
                userLocation.text = "\(user.location ?? "")"
                profileImageView.image = base64ToImage(base64: user.image)
                
                var majorString = ""
                for major in user.majors {
                    majorString += MajorMap.getString(major: Major(rawValue: major)!)
                    majorString += "\n"
                }
                userMajors.text = majorString
                
            } catch {
                print("decode error")
                return
            }
        }
    }
    

    
    @IBAction func logoutTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "userData")
        UserDefaults.standard.set(false, forKey:"isUserLoggedIn")
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
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
