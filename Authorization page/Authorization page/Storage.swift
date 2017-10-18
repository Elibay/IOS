//
//  File.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 29.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import Cache

private struct Caches {
    static let cache = SpecializedCache < UIImage > (name: "UIImage Cache")
}
private struct Constants {
    static let image = "Image"
}

struct Storage {
    static func setImage (image: UIImage, url: String) {
        Caches.cache.async.addObject (image, forKey: url) { error in
//            print (error)
        }
    }
    static func getImage (url: String) -> UIImage? {
        Caches.cache.async.object(forKey: url) { (image: UIImage?) in
            return image
        }
        return nil
    }
}
