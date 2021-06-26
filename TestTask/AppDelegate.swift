//
//  AppDelegate.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 23.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = MainModule.configure(title: "Launches SpaceX")
        window?.rootViewController = UINavigationController(rootViewController: root)
        window?.makeKeyAndVisible()
        
        return true
    }

}

