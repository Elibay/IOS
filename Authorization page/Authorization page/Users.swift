//
//  Users.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 23.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct User: Mappable {
    
    // MARK: - outlets
    var token = ""
    var id = 0
    var email = ""
    var name = ""
    var imageUrl = ""
    
    // MARK: - setting data
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        token <- map["token"]
        id <- map["user.id"]
        email <- map["user.username"]
        name <- map["user.full_name"]
        imageUrl <- map["user.avatar"]

    }
    
    // MARK: - authorization function
    static func Authorize (email: String, password: String, completion: @escaping (User?, String?) -> Void) {
        let parameters = ["username": email, "password": password]
        let url = "https://apivotem.solf.io/api/authe/login/"
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    completion(User(JSON: json)!, nil)
                case 6:
                    completion(nil, "Введите правильный email")
                default:
                    completion (nil, "Введите правильный пароль")
                }
            case .failure(let error):
            completion(nil, error.localizedDescription)
            }
        }
    }
}
