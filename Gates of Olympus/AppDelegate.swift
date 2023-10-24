//
//  AppDelegate.swift
//  Gates of Olympus
//
//  Created by Nandini Vithlani on 16/10/23.
//


import UIKit
import BAKFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate  {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        BAKService.shared.setupUIAnalytics(appOrientation: .portrait, launchOptions: launchOptions, window: &window) {
            return ContentView()
        }
    
        return true
    }

   func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
       return BAKService.orientationLock
    }
}
