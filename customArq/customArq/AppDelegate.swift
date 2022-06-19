//
//  AppDelegate.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if self.window != nil {
            BaseRouter.setRoot(navigationController: HomeAssembly.homeNavigationView())
        }
        return true
    }
}

