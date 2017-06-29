//
//  Storyboard.swift
//  Authorization page
//
//  Created by Elibay Nuptebek on 29.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

private struct Constants {
    static let main = "Main"
    static let authorizationPage = "MainView"
    static let userPage = "User Page"
}
struct Storyboard {
    private static let authorization = UIStoryboard(name: Constants.main, bundle: nil)
    // controller'ы
    static var authorizationPage: UINavigationController {
        return authorization.instantiateViewController(withIdentifier: Constants.authorizationPage) as! UINavigationController
    }
    static var userPage: UserPageViewController {
        return authorization.instantiateViewController(withIdentifier: Constants.userPage) as! UserPageViewController
    }
}
