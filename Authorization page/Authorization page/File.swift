//
//  File.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 28.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire
struct ImageDownloader {
    static func fetchImage(with url: String,
                           completion: @escaping (UIImage) -> Void) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }
}
