//
//  UserPostOrJobViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 1/30/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class UserPostOrJobViewController: UIViewController {

    var userToken: String?
    var pageFlag: String?
    
    @IBOutlet weak var flag: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        flag.text = pageFlag
        // Do any additional setup after loading the view.
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
