//
//  SigninViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/27/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmedPasswordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var standingTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var major1TextField: UITextField!
    @IBOutlet weak var major2TextField: UITextField!
    @IBOutlet weak var major3TextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let standingPicker = UIPickerView()
    let major1Picker = UIPickerView()
    let major2Picker = UIPickerView()
    let major3Picker = UIPickerView()
    let imagePicker = UIImagePickerController()
    
    var totalStandings: [String] = []
    var totalMajors: [String] = []
    
    var standing: Int? = nil
    var major1: Int? = nil
    var major2: Int? = nil
    var major3: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.keyboardDismissMode = .onDrag
        
        activityIndicator.isHidden = true
        
        signupButton.layer.cornerRadius = 10
        backToLoginButton.layer.cornerRadius = 10
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextView.layer.cornerRadius = 5
        
        Standing.allCases.forEach {
            totalStandings.append(StandingMap.getString(standing: $0))
        }
        
        Major.allCases.forEach {
            totalMajors.append(MajorMap.getString(major: $0))
        }
        
        standingTextField.inputView = standingPicker
        major1TextField.inputView = major1Picker
        major2TextField.inputView = major2Picker
        major3TextField.inputView = major3Picker
        
        standingPicker.delegate = self
        major1Picker.delegate = self
        major2Picker.delegate = self
        major3Picker.delegate = self
        imagePicker.delegate = self
        
        profileImageView.image = UIImage(named: "DefaultProfile")
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.loading()
        
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmedPassword = confirmedPasswordTextField.text
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let standingString = standingTextField.text
        let location = locationTextField.text
        let major1String = major1TextField.text
        let description = descriptionTextView.text

        let profileImage = profileImageView.image

        if email == nil || email!.isEmpty {
            displayAlert(message: "Email Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if password == nil || password!.isEmpty {
            displayAlert(message: "Password Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if confirmedPassword == nil || confirmedPassword!.isEmpty {
            displayAlert(message: "Confirmed Password Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if firstName == nil || firstName!.isEmpty {
            displayAlert(message: "FirstName Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if lastName == nil || lastName!.isEmpty {
            displayAlert(message: "LastName Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if standingString == nil || standingString!.isEmpty {
            displayAlert(message: "Standing Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if location == nil || location!.isEmpty {
            displayAlert(message: "Location Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if major1String == nil || major1String!.isEmpty {
            displayAlert(message: "Major1 Cannot be empty")
            self.loadingComplete()
            return
        }
        
        if password != confirmedPassword {
            displayAlert(message: "Password and Confirmed Password are not matched")
            self.loadingComplete()
            return
        }
        
        if !isValidPassword(password: password!) {
            displayAlert(message: "Password must be more than 6 characters, with at least one capital, numeric or special character")
            self.loadingComplete()
            return
        }
        
        var signupUser = UserSignUpRequest.init(email: email!, password: password!, firstName: firstName!, lastName: lastName!, majors: [], image: nil, role: -1, standing: -1, location: location!, description: nil, resume: nil)
  
        // major
        if let major1 = major1 {
            signupUser.majors.append(major1)
        }
        if let major2 = major2 {
            signupUser.majors.append(major2)
        }
        if let major3 = major3 {
            signupUser.majors.append(major3)
        }
        // image
        if profileImage != nil && profileImage! != UIImage(named: "DefaultProfile") {
            signupUser.image = toBase64(image: profileImage!)
        }
        
        // role
        if let standing = standing {
            signupUser.standing = standing
            if standing == Standing.Professor.rawValue {
                signupUser.role = Role.Professor.rawValue
            } else {
                signupUser.role = Role.Student.rawValue
            }
        }
        
        // description
        if description != nil {
            signupUser.description = description!
        }
        
        //print(signupUser)
        UserService.SignUp(userSignupRequest: signupUser, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
                self.loadingComplete()
            } else {
                let encoder = JSONEncoder()
                print(user?.id)
                do {
                    let data = try encoder.encode(user)
                    UserDefaults.standard.set(data, forKey: "userData")
                    UserDefaults.standard.set(true, forKey:"isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: true, completion: nil)
                } catch {
                    print("save user data error")
                    self.displayAlert(message: "Something went wrong")
                    self.loadingComplete()
                }
            }
        }
    }
    
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add a profile picture", message: "How do you want to upload the picture?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { action in
            self.takePhotoWithCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Use Existing Photo", style: .default, handler: { action in
            self.getPhotoFromLibrary()
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func backLoginTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func toBase64(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0) else { return nil }
        return imageData.base64EncodedString()
    }
    
    func loading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        backToLoginButton.isEnabled = false
        signupButton.isEnabled = false
    }
    
    func loadingComplete() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        backToLoginButton.isEnabled = true
        signupButton.isEnabled = true
    }

}

extension SignupViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
            standingTextField.text = totalStandings[row]
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

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            let alertController = UIAlertController(title: "No Camera", message: "The device has no camera.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getPhotoFromLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            profileImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}


