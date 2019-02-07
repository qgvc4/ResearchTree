//
//  NewJobViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/7/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class NewJobViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var major1TextField: UITextField!
    @IBOutlet weak var major2TextField: UITextField!
    @IBOutlet weak var major3TextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.keyboardDismissMode = .onDrag
        
        activityIndicator.isHidden = true
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextView.layer.cornerRadius = 5
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.loading()
        
        let title = titleTextField.text
        let description = descriptionTextView.text
        let major1String = major1TextField.text
        let location = locationTextField.text
        
        if title == nil || title!.isEmpty {
            displayAlert(message: "title cannot be empty")
            self.loadingComplete()
            return
        }
        
        if description == nil || description!.isEmpty {
            displayAlert(message: "description cannot be empty")
            self.loadingComplete()
            return
        }
        
        if major1String == nil || major1String!.isEmpty {
            displayAlert(message: "major1 cannot be empty")
            self.loadingComplete()
            return
        }
        
        if location == nil || location!.isEmpty {
            displayAlert(message: "location cannot be empty")
            self.loadingComplete()
            return
        }
        
        // get current user
        var user: User?
        let userData = UserDefaults.standard.data(forKey: "userData")
        let decoder = JSONDecoder()
        if let userData = userData {
            do {
                user = try decoder.decode(User.self, from: userData)
            } catch {
                print("decode error")
            }
        }
        
        if let user = user {
            var newJob = postJobRequest.init(title: title!, peopleId: user.id, description: description!, majors: [], standing: 0, payment: false, location: location!)
            
            newJob.majors = [0, 1]
            newJob.standing = 1
            newJob.payment = true
            
            JobService.postJob(userToken: user.token! ,postJobRequest: newJob, dispatchQueueForHandler: DispatchQueue.main) {
                (job, errorString) in
                if errorString != nil {
                    self.displayAlert(message: errorString!)
                    self.loadingComplete()
                } else {
                    self.navigationController?.popViewController(animated: true)
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
    
    func loading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        saveButton.isEnabled = false
    }
    
    func loadingComplete() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        saveButton.isEnabled = true
    }
}
