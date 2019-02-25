//
//  MyJobsDetailViewController.swift
//  ResearchTree
//
//  Created by Melissa Hollingshed on 2/25/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class MyJobsDetailViewController: UIViewController {

    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var job: Job?
    var userToken: String?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        showJobDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        JobService.getJob(userToken: self.userToken!, jobId: job!.id, dispatchQueueForHandler: DispatchQueue.main) {
            (job, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let job = job {
                    self.job = job.mapToJob(rawJob: job)
                    self.showJobDetail()
                }
            }
        }
        
    }
    
    func showJobDetail() {
        if job == nil {
            return
            
        }
        
        jobLabel.text = job!.title
        descriptionLabel.text = job!.description
        levelLabel.text = StandingMap.getString(standing: job!.standing)
        if job!.payment {
            paymentImageView.image = UIImage(named: "money")!
        } else {
            paymentImageView.image = nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        dateLabel.text = dateFormatter.string(from: job!.modifyTime)
        var majorString = ""
        for major in job!.majors {
            majorString += MajorMap.getString(major: major)
            majorString += "\n"
        }
        majorLabel.text = majorString
        
        UserService.getUser(userToken: self.userToken!, userId: job!.peopleId, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                if let user = user {
                    self.user = user
                    self.userName.text = "\(user.firstname) \(user.lastname)"
                    self.emailLabel.text = "\(user.email)"
                    self.userImage.image = self.base64ToImage(base64: user.image)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editJobSegue",
            let destination = segue.destination as? EditMyJobsViewController {
            destination.userToken = userToken
            destination.myJobs = self.job
        }
    }
    
}
