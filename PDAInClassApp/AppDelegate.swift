//
//  AppDelegate.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-04-09.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        //try? Auth.auth().signOut()
        return true
    }
}
