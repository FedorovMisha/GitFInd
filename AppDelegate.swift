//
//  AppDelegate.swift
//  GitFind
//
//  Created by Misha Fedorov on 05.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let navigationViewController = UINavigationController()
    var navigator: AppNavigator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        navigator = AppNavigator(navigationViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationViewController
        navigator?.navigate(to: .toFindScreen)
        window?.makeKeyAndVisible()
        return true
    }
}

