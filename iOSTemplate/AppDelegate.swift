//
//  AppDelegate.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 17/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DIContainer.default.config()
        BaseNavigationController.setupAppearance()
        
        let vc = DIContainer.default.resolve(type: ListAssemblyProtocol.self)!
            .listViewController()
        let nav = BaseNavigationController(rootViewController: vc)

        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        return true
    }

}
