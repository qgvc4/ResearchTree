//
//  UserViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/29/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var userToken: String?
    var users: [User] = []
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestUsers), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usersCollectionView.refreshControl = refresher
        // Do any additional setup after loading the view.
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
            
            refresher.beginRefreshing()
            requestUsers()
        }
    }

    @objc
    func requestUsers() {
        if (self.userToken == nil) {
            return
        }
        
        UserService.getUsers(userToken: self.userToken!, dispatchQueueForHandler: DispatchQueue.main) {
            (users, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let users = users {
                    self.users.removeAll()
                    for user in users {
                        self.users.append(user)
                    }
                    
                    self.refresher.endRefreshing()
                    self.usersCollectionView.reloadData()
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
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath)
        if let cell = cell as? UserCollectionViewCell {
            let user = users[indexPath.row]
            cell.userName.text = "\(user.firstname) \(user.lastname)"
            cell.userImageView.image = self.base64ToImage(base64: user.image)
            cell.role.text = StandingMap.getString(standing: Standing(rawValue: user.standing)!)
            var majorString = ""
            for major in user.majors {
                majorString += MajorMap.getString(major: Major(rawValue: major)!)
                majorString += "\n"
            }
            cell.majors.text = majorString
            
            if user.standing == Standing.Professor.rawValue {
                cell.backgroundColor = hexStringToUIColor(hex: "#87C07C")
            } else if user.standing == Standing.Graduate.rawValue {
                cell.backgroundColor = hexStringToUIColor(hex: "#4E6E94")
            } else if user.standing == Standing.Undergraduate.rawValue {
                cell.backgroundColor = hexStringToUIColor(hex: "#75A7E4")
            }
        }
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.usersCollectionView.frame.width * 0.48, height: 280)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetailSegue" {
            let destination = segue.destination as! UserDetailViewController
            let cell = sender as! UserCollectionViewCell
            let indexPaths = usersCollectionView.indexPath(for: cell)
            destination.userToken = self.userToken
            destination.user = users[indexPaths!.row]
            //feedsTableView.deselectRow(at: feedsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}
