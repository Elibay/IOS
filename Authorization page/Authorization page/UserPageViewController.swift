//
//  HelloPageViewController.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 23.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class UserPageViewController: UIViewController, NVActivityIndicatorViewable {
    // MARK: - outlets
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
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
        if user == nil {
            user = Storage.user
        }
        nameText?.text = user.name
        ImageDownloader.fetchImage(with: user.imageUrl) { image in
            self.spiner.stopAnimating()
            self.avatarImage.image = image
        }
    }
    @IBAction func logOut(_ sender: UIButton) {
        Storage.user = nil
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "MainView")
        self.present(secondVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.avatarImage.layer.borderWidth = 3.0;
        self.avatarImage.layer.borderColor = UIColor.black.cgColor
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2;
        self.avatarImage.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        updateUI()
    }
}
