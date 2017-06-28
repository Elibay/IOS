//
//  WelcomePageViewController.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 22.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

extension UIViewController {
    static let Color = UIColor (red: 255/255, green: 109/255, blue: 0/255, alpha: 1)

    func validateEmail(_ enteredEmail: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPredicate.evaluate(with: enteredEmail)
    }
    func showAlert (_ message: String)
    {
        let title = "УПС!"
        let answer = "OK"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: answer, style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

private struct Contstants {
    static let passwordSegue = "Show Password Segue"
}

class WelcomePageViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet private weak var emailText: UITextField!
    @IBOutlet private weak var viewer: UIView!
    
    // MARK: - actions
    @IBAction func emailDidEnd(_ sender: UITextField) {
        viewer.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func emailDidBegin(_ sender: UITextField) {
        viewer.backgroundColor = UIViewController.Color
    }
    
    @IBAction func editingEmail(_ sender: UITextField) {
        if !emailText.text!.isEmpty {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Далее", style: UIBarButtonItemStyle.plain, target: nil, action: #selector (WelcomePageViewController.showPasswordPage))
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func showPasswordPage() {
        let email = emailText.text!
        
        // проверка на правильность емайла
        if validateEmail(email) == false {
            showAlert ("Введите правильный email")
            return
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        emailText.delegate = self
    }
}
extension WelcomePageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showPasswordPage()
        return true
    }
}
