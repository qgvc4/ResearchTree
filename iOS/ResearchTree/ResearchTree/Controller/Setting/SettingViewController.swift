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
    
    @IBOutlet weak var postsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var myJobButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheming()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (isUserLoggedIn) {
            
            profileImageView.layer.borderWidth = 5
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.borderColor = UIColor.white.cgColor
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true

            
            logoutButton.layer.cornerRadius = logoutButton.frame.height/2
            logoutButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            logoutButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            logoutButton.layer.shadowOpacity = 1.0
            logoutButton.layer.shadowRadius = 0.0
            logoutButton.layer.masksToBounds = false
          
            postsButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            postsButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            postsButton.layer.shadowOpacity = 1.0
            postsButton.layer.shadowRadius = 0.0
            postsButton.layer.masksToBounds = false
            postsButton.layer.cornerRadius = 4.0
 
            
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
                
                if user.role == Role.Professor.rawValue {
                    myJobButton.isEnabled = true
                    myJobButton.isHidden = false
                } else {
                    myJobButton.isEnabled = false
                    myJobButton.isHidden = true
                }
                
            } catch {
                print("decode error")
                return
            }
        }
    }
    

    @IBOutlet weak var cardView2: UIView!
    @IBOutlet weak var cardView: UIView!
    
    
    @IBAction func themeTapped(_ sender: Any) {
        
        themeProvider.nextTheme()


        
       
            
        
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

extension SettingViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        view.backgroundColor = theme.backgroundColor
        cardView.backgroundColor = theme.cardview
        cardView2.backgroundColor = theme.cardview2
        userEmail.textColor = theme.textColor
        userLocation.textColor = theme.textColor
        userMajors.textColor = theme.textColor
        postsButton.backgroundColor = theme.postsButton
        myJobButton.backgroundColor = theme.myJobButton
        logoutButton.backgroundColor = theme.logoutButton
     //  titleLabel.textColor = theme.textColor
       // subtitleLabel.textColor = theme.textColor
    }
}
