//
//  TableViewCell.swift
//  baribir
//
//  Created by Elibay Nuptebek on 05.07.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: - outlets
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    var info: (avatar: UIImage, fullName: String)! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        print ("Hello Bro")
        avatarImage.image = info!.avatar
        labelText.text = info!.fullName
    }
}
