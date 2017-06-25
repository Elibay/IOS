//
//  PasswordViewController.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 22.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class PasswordViewController: UIViewController, NVActivityIndicatorViewable {
    // MARK: - outlets
    @IBOutlet weak var passwordText: UITextField!
    var email: String!
    @IBOutlet weak var Viewer: UIView!
    
    // MARK: - actions
    @IBAction func passwordDidEnd(_ sender: UITextField) {
        Viewer.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func passwordDidBegin(_ sender: UITextField) {
        Viewer.backgroundColor = UIViewController.Color
    }
    
    @IBAction func nextSegueAction(_ sender: UITextField) {
        let password = passwordText.text!
        if password.characters.count < 4 {
            let alert = UIAlertController(title: "УПС!", message: "Слишком короткий пароль", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        startAnimating()
        User.Authorize(email: email, password: password) { user, message in
            self.stopAnimating()
            if let message = message {
                print (message)
            } else {
                self.performSegue(withIdentifier: UIViewController.Contstants.userInfoSegue,
                                  sender: user!)
            }
        }
    }
    @IBAction func PasswordEditingAction(_ sender: UITextField) {
        Viewer.backgroundColor = UIColor (red: 205/255, green: 109/255, blue: 0/255, alpha: 1)
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
        print (segue.identifier!)
        switch segue.identifier! {
        case UIViewController.Contstants.userInfoSegue:
            let destinationVC = segue.destination as! HelloPageViewController
            destinationVC.user = sender as! User
        default: break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
}
