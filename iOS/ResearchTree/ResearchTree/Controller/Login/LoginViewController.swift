//
//  LoginViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/13/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 10
        signupButton.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (isUserLoggedIn) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (email == nil || password == nil ) {
            displayAlert(message: "email or password cannot be empty")
            return
        }
        
        if (email!.isEmpty || password!.isEmpty) {
            displayAlert(message: "email or password cannot be empty")
            return
        }
        
        let user = UserLoginRequest.init(email: email!, password: password!)
        UserService.LogIn(userCredential: user, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
            } else {
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(user)
                    UserDefaults.standard.set(data, forKey: "userData")
                    UserDefaults.standard.set(true, forKey:"isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: true, completion: nil)
                } catch {
                    print("save user data error")
                    self.displayAlert(message: "Something went wrong")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
