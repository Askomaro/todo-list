//
//  ViewController.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/5/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    private let apiClient : APIClient = APIClient()
    private var registerIsOn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func SignInSwitcher(_ sender: UISwitch) {
        registerIsOn = sender.isOn
        
        if (sender.isOn){
            LoginButton.setTitle("Register", for: .normal)
        } else {
            LoginButton.setTitle("Log in", for: .normal)
        }
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        if EmailTextField.text == ""{
            showErrorPopup(msg: "Email is required")
            return
        }
        if PasswordTextField.text == ""{
            showErrorPopup(msg: "Password is required")
            return
        }
        
        if (registerIsOn) {
            apiClient.createUser(
                email: EmailTextField.text!,
                password: PasswordTextField.text!,
                completionHandler: {error in
                    if let error = error {
                        self.showErrorPopup(msg : error.message)
                    } else {
                        self.apiClient.getTasks{ tasks, error in
                            if let error = error {
                                self.showErrorPopup(msg : error.message)
                            }
                        }
                    }
            })
        } else {
            apiClient.authorizeUser(
                email: EmailTextField.text!,
                password: PasswordTextField.text!,
                completionHandler: {error in
                    if let error = error {
                        self.showErrorPopup(msg : error.message)
                    } else {
                        self.apiClient.getTasks{ tasks, error in
                            if let error = error {
                                self.showErrorPopup(msg : error.message)
                            }
                        }
                    }
            })
        }
    }
    
    private func showErrorPopup(msg : String?) -> Void {
        let alertController = UIAlertController(title: "Error", message:
            msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

