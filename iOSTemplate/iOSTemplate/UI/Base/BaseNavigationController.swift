// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import Common

public class BaseNavigationController: UINavigationController {
    
    static func setupAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [BaseNavigationController.self])
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .navigationBarBackgroundColor
            appearance.shadowImage = UIImage(color: .clear)
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.navigationBarTintColor,
            ]
            navigationBarAppearance.standardAppearance = appearance
            navigationBarAppearance.scrollEdgeAppearance = appearance
        }
        else {
            navigationBarAppearance.shadowImage = UIImage()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.navigationBarTintColor,
            ]
        }
        
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.barTintColor = .navigationBarBackgroundColor
        navigationBarAppearance.tintColor = .navigationBarTintColor
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }

}
