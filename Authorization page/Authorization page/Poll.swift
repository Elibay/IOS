//
//  Polls.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 05.07.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
struct Poll: Mappable {
    
    var imageUrl: String? = nil
    var text = ""
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        imageUrl <- map["image"]
        text <- map["title"]
    }
    static func getItems ( completion: @escaping ([Poll]?, String?) -> Void) {
        let url = "https://apivotem.solf.io/api/polls/feed/"
        Alamofire.request(url, method: .post).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                if code != 0 {
                    completion (nil, "OSHIBKA")
                }
                else
                {
                    let JSON = json["result"] as! [[String: Any]]
                    completion(JSON.map {Poll(JSON: $0)!}, nil)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
