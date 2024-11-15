// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import Common

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DIContainer.default.config()
        BaseNavigationController.setupAppearance()
        
        let vc = DIContainer.default.resolve(type: ListBuilderProtocol.self)!
            .listViewController()
        let nav = BaseNavigationController(rootViewController: vc)

        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        return true
    }

}
