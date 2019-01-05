//
//  SigninViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/27/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmedPasswordTextField: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmedPassword = confirmedPasswordTextField.text
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
    
        if email == nil || password == nil || confirmedPassword == nil || firstName == nil || lastName == nil {
            
            displayAlert(message: "All field are required")
            return
        }
    
        if email!.isEmpty || password!.isEmpty || confirmedPassword!.isEmpty || firstName!.isEmpty || lastName!.isEmpty {
            
            displayAlert(message: "All fields are required")
            return
        }
        
        if password != confirmedPassword {
            
            displayAlert(message: "Password and Confirmed Password are not matched")
            return
        }
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
