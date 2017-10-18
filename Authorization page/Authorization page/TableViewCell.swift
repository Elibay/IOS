//
//  TableViewCell.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 05.07.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: - outlets
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var info: (Poll)! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        avatarImage.image = nil
        var url = "http://www.statusyblog.ru/1/8/shenok.jpg"
//        var url = info.imageUrl!
        if url == "" {
            url = "123"
        }
        let img = Storage.getImage(url: url)
        if img != nil {
            avatarImage.image = img!
        }
        else {
            spinner.startAnimating()
            if url != "123" {
                ImageDownloader.fetchImage(with: url) { image in
                    self.avatarImage.image = image
                    self.spinner.stopAnimating()
                    Storage.setImage(image: image, url: url)
                }
            } else {
                self.spinner.stopAnimating()
                self.avatarImage.image = #imageLiteral(resourceName: "avatar")
                Storage.setImage(image: #imageLiteral(resourceName: "avatar"), url: url)
            }
            
        }
        labelText.text = info!.text
    }
}
