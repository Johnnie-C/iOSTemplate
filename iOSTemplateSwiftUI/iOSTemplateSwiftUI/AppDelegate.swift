//
//  AppDelegate.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 5/11/22.
//

import UIKit
import Common

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FontStyle.setFontProvider(AppFontProvider())
        return true
    }
    
}
