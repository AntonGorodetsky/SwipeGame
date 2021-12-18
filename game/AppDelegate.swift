//
//  AppDelegate.swift
//  aniswipe
//
//  Created by Anton Gor on 13.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .gray
    window?.rootViewController = GameVC()
//    window?.rootViewController = ViewController()
    
    window?.makeKeyAndVisible()
    
    return true
  }

  
}
