//
//  LoginViewController.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/13/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signupButton.layer.cornerRadius = 10
        signupButton.layer.cornerRadius = loginButton.frame.height/2
        signupButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        signupButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        signupButton.layer.shadowOpacity = 1.0
        signupButton.layer.shadowRadius = 0.0
        signupButton.layer.masksToBounds = false
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        loginButton.layer.shadowOpacity = 1.0
        loginButton.layer.shadowRadius = 0.0
        loginButton.layer.masksToBounds = false
        
        cardView.layer.cornerRadius = cardView.frame.height/2
        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.shadowRadius = 0.0
        cardView.layer.masksToBounds = false
        
        
        activityIndicator.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if (isUserLoggedIn) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        self.loading()
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (email == nil || password == nil ) {
            displayAlert(message: "email or password cannot be empty")
            self.loadingComplete()
            return
        }
        
        if (email!.isEmpty || password!.isEmpty) {
            displayAlert(message: "email or password cannot be empty")
            self.loadingComplete()
            return
        }
        
        let user = UserLoginRequest.init(email: email!, password: password!)
        UserService.logIn(userCredential: user, dispatchQueueForHandler: DispatchQueue.main) {
            (user, errorString) in
            if errorString != nil {
                self.displayAlert(message: errorString!)
                self.loadingComplete()
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
                    self.loadingComplete()
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
    
    func loading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        signupButton.isEnabled = false
    }
    
    func loadingComplete() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        loginButton.isEnabled = true
        signupButton.isEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
