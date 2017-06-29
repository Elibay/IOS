//
//  File.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 29.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import Cache

private struct Caches {
    static let jsonCache = SpecializedCache < JSON > (name: "JSON Cache")
}
private struct Constants {
    static let user = "User"
}

struct Storage {
    static var user: User? {
        get {
            if let json = Caches.jsonCache.object(forKey: Constants.user) {
                switch json {
                case .dictionary(let userJson): return User (JSON: userJson)!
                default:
                    break
                }
            }
            return nil
        }
        set {
            if let user = newValue {
                try! Caches.jsonCache.addObject(JSON.dictionary (user.toJSON()), forKey: Constants.user)
            }
            else {
                try! Caches.jsonCache.removeObject(forKey: Constants.user)
            }
        }
    }
}
