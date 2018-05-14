//
//  ViewController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-04-09.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(presentLogin), with: self, afterDelay: 0)
    }
    
    @objc func presentLogin (){
        if Auth.auth().currentUser == nil {
            // logged out
            let storyboard = UIStoryboard(name: "LoginController", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            
            present(controller, animated: true, completion: nil)
        }
    }
    
}

