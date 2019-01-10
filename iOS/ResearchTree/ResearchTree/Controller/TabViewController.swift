//
//  TabViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/27/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
//        } else {
//            let userData = UserDefaults.standard.data(forKey: "userData")
//            let decoder = JSONDecoder()
//            do {
//                let user = try decoder.decode(User.self, from: userData!)
//                print(user.token)
//            } catch {
//                print("decode error")
//
//            }
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
