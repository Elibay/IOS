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
    // MARK: - outlets
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // MARK: - actions
    var user: User! {
        didSet {
            updateUI()
        }
    }
    private func updateUI () {
        nameText?.text = user.name
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
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2;
        self.avatarImage.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        updateUI()
    }
}
