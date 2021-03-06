//
//  EditMyJobsViewController.swift
//  ResearchTree
//
//  Created by Melissa Hollingshed on 2/25/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class EditMyJobsViewController: UIViewController {


    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var major1TextField: UITextField!
    @IBOutlet weak var major2TextField: UITextField!
    @IBOutlet weak var major3TextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var paymentSwitch: UISwitch!
    @IBOutlet weak var levelTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let standingPicker = UIPickerView()
    let major1Picker = UIPickerView()
    let major2Picker = UIPickerView()
    let major3Picker = UIPickerView()
    
    var totalStandings: [String] = []
    var totalMajors: [String] = []
    
    var standing: Int? = nil
    var major1: Int? = nil
    var major2: Int? = nil
    var major3: Int? = nil
    
    var myJobs: Job?
    var userToken: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.keyboardDismissMode = .onDrag
        
        activityIndicator.isHidden = true
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextView.layer.cornerRadius = 5
        
        Standing.allCases.forEach {
            totalStandings.append(StandingMap.getString(standing: $0))
        }
        
        Major.allCases.forEach {
            totalMajors.append(MajorMap.getString(major: $0))
        }
        
        levelTextField.inputView = standingPicker
        major1TextField.inputView = major1Picker
        major2TextField.inputView = major2Picker
        major3TextField.inputView = major3Picker
        
        
        if let myJobs = myJobs {
            titleTextField.text = myJobs.title
            descriptionTextView.text = myJobs.description
            if myJobs.payment {
                paymentSwitch.isOn = true
            }
            
            var majorsString: [String] = []
            for major in myJobs.majors {
                majorsString.append(MajorMap.getString(major: major))
            }
            
            major1TextField.text = majorsString[0]
            major1 = totalMajors.firstIndex(of: majorsString[0])
            if majorsString.count >= 2 {
                major2TextField.text = majorsString[1]
                major2 = totalMajors.firstIndex(of: majorsString[1])
            }
            if majorsString.count == 3 {
                major3TextField.text = majorsString[2]
                major3 = totalMajors.firstIndex(of: majorsString[2])
            }
            
            locationTextField.text = myJobs.location

            levelTextField.text = StandingMap.getString(standing: myJobs.standing)
        }
        
        standingPicker.delegate = self
        major1Picker.delegate = self
        major2Picker.delegate = self
        major3Picker.delegate = self
        
        
        
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
        
        if let user = user, let myJobs = myJobs {
            var editJob = PostPutJobRequest.init(title: title!, peopleId: user.id, description: description!, majors: [], standing: 0, payment: false, location: location!)
            
            // major
            if let major1 = major1 {
                editJob.majors.append(major1)
            }
            if let major2 = major2 {
                editJob.majors.append(major2)
            }
            if let major3 = major3 {
                editJob.majors.append(major3)
            }
            
            // standing
            if let standing = standing {
                editJob.standing = standing
            }
            
            // payment
            editJob.payment = paymentSwitch.isOn
            
            JobService.updateJob(userToken: user.token!, jobId: myJobs.id, putJobRequest: editJob, dispatchQueueForHandler: DispatchQueue.main) {
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

extension EditMyJobsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == standingPicker {
            return totalStandings.count
        } else if pickerView == major1Picker || pickerView == major2Picker || pickerView == major3Picker {
            return totalMajors.count
        }
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == standingPicker {
            return totalStandings[row]
        } else if pickerView == major1Picker || pickerView == major2Picker || pickerView == major3Picker {
            return totalMajors[row]
        }
        return nil
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == standingPicker {
            levelTextField.text = totalStandings[row]
            standing = row
        } else if pickerView == major1Picker {
            major1TextField.text = totalMajors[row]
            major1 = row
        } else if pickerView == major2Picker {
            major2TextField.text = totalMajors[row]
            major2 = row
        } else if pickerView == major3Picker {
            major3TextField.text = totalMajors[row]
            major3 = row
        }
    }
}
