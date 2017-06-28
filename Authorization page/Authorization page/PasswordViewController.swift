//
//  PasswordViewController.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 22.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private struct constants
{
    static let userInfoSegue = "Hello Page Segue"
}

class PasswordViewController: UIViewController, NVActivityIndicatorViewable {
    // MARK: - outlets
    @IBOutlet weak var passwordText: UITextField!
    var email: String!
    
    @IBOutlet weak var viewer: UIView!
    // MARK: - actions
    @IBAction func passwordDidEnd(_ sender: UITextField) {
        viewer.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func passwordDidBegin(_ sender: UITextField) {
        viewer.backgroundColor = UIViewController.Color
    }
    
    @IBAction func nextSegueAction() {
        let password = passwordText.text!
        if password.characters.count < 4 {
            showAlert( "Слишком короткий пароль")
            return
        }
        startAnimating()
        User.Authorize(email: email, password: password) { user, message in
            self.stopAnimating()
            if let message = message {
                self.showAlert (message)
                return
            } else {
                self.performSegue(withIdentifier: constants.userInfoSegue, sender: user!)
            }
        }
    }
    @IBAction func passwordEditingAction(_ sender: UITextField) {
        viewer.backgroundColor = UIViewController.Color
        if !passwordText.text!.isEmpty {
            if self.navigationItem.rightBarButtonItem == nil {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Далее", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(PasswordViewController.nextSegueAction))
            }
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    // MARK: - навигация
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case constants.userInfoSegue:
            let destinationVC = segue.destination as! HelloPageViewController
            destinationVC.user = sender as! User
        default: break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        passwordText.delegate = self
    }
}
extension PasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        nextSegueAction()
        return true
    }
}
