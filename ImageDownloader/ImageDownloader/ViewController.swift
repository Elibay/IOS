//
//  ViewController.swift
//  ImageDownloader
//
//  Created by Elibay Nuptebek on 02.07.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBAction func changeImage(_ sender: Any) {
        let url = ""
        ImageDownloader.fetchImage(with: url) { image in
            self.backgroundImage.image = image
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

