//
//  WelcomePageViewController.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 22.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    static let Color = UIColor (red: 255/255, green: 109/255, blue: 0/255, alpha: 1)
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func validateEmail(_ enteredEmail: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPredicate.evaluate(with: enteredEmail)
    }
    struct Contstants {
        static let passwordSegue = "Show Password Segue"
        static let userInfoSegue = "Hello Page Segue"
    }
}


class WelcomePageViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var Viewer: UIView!
    
    // MARK: - actions
    @IBAction func emailDidEnd(_ sender: UITextField) {
        Viewer.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func emailDidBegin(_ sender: UITextField) {
        Viewer.backgroundColor = UIViewController.Color
    }
    
    @IBAction func editingEmail(_ sender: UITextField) {
        if !emailText.text!.isEmpty {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Далее", style: UIBarButtonItemStyle.plain, target: nil, action: #selector (WelcomePageViewController.ShowPasswordPage))
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    func ShowPasswordPage(_ sender: UIBarButtonItem) {
        
        let email = emailText.text!
        
        // проверка на правильность емайла
        if validateEmail(email) == false {
            let alert = UIAlertController(title: "УПС!", message: "Введите правильный email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        performSegue(withIdentifier: Contstants.passwordSegue, sender: email)
    }
    
    // MARK: - навигация
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Contstants.passwordSegue:
            let destinationVC = segue.destination as! PasswordViewController
            destinationVC.email = sender as! String
        default:
            break
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
}
