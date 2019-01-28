//
//  SettingViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/28/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "userData")
        UserDefaults.standard.set(false, forKey:"isUserLoggedIn")
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
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
