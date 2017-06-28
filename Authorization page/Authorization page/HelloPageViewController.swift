//
//  HelloPageViewController.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 23.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HelloPageViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    var user: User! {
        didSet {
            updateUI()
        }
    }
    private func updateUI () {
        nameText?.text = user.name
        emailText?.text = user.email
        self.startAnimating ()
        ImageDownloader.fetchImage(with: user.imageUrl) { image in
            self.stopAnimating()
            self.avatarImage.image = image
        }
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
