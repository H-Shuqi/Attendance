//
//  AppDelegate.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/1/13.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        let rootNavC:UIViewController!
        if User.sharedInstance.userId == nil {
            rootNavC = StartViewController()
        }else{
            rootNavC = HNavigationController(rootViewController: HomeViewController())
        }
        
        self.window!.rootViewController = rootNavC
        self.window!.makeKeyAndVisible()
        return true
    }
    
}

