//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Elibay Nuptebek on 02.07.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//
import Alamofire
import AlamofireImage

struct ImageDownloader {
    static func fetchImage(with url: String, completion: @escaping (UIImage) -> Void) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }
}
