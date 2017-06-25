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
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}
