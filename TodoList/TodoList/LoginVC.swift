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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBAction func LoginButton(_ sender: Any) {
        if EmailTextField.text == ""{
            showErrorPopup(msg: "Email is required")
            return
        }
        if PasswordTextField.text == ""{
            showErrorPopup(msg: "Password is required")
            return
        }
        
        apiClient.authorizeUser(
            email: EmailTextField.text!,
            password: PasswordTextField.text!,
            completionHandler: {error in
                if let error = error{
                    self.showErrorPopup(msg : error.message)
                } else {
                    self.apiClient.getTasks{
                        if let error = $1 {
                            self.showErrorPopup(msg : error.message)
                        }
                    }
                }
        })
    }
    
    private func showErrorPopup(msg : String?) -> Void {
        let alertController = UIAlertController(title: "Error", message:
            msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

