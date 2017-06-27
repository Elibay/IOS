//
//  HelloPageViewController.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 23.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class HelloPageViewController: UIViewController {
    @IBOutlet weak var helloPageText: UILabel!
    var user: User! {
        didSet {
            updateUI()
        }
    }
    private func updateUI () {
        helloPageText?.text = user.email
    }
    @IBAction func logOut(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "MainView")
        
        self.present(secondVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        updateUI()
    }
}
