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
        configFonts()
        return true
    }
    
    private func configFonts() {
        UIFont.registerFont()
        
        let book = UIFont(name: "StagSans-Book", size: 1)!
        let bookItalic = UIFont(name: "StagSans-BookItalic", size: 1)!
        let black = UIFont(name: "StagSans-Black", size: 1)!
        let blackItalic = UIFont(name: "StagSans-BlackItalic", size: 1)!
//        let bold = UIFont(name: "StagSans-Bold", size: 1)!
        let boldItalic = UIFont(name: "StagSans-BoldItalic", size: 1)!
        let medium = UIFont(name: "StagSans-Medium", size: 1)!
        let mediumItalic = UIFont(name: "StagSans-MediumItalic", size: 1)!
        let semibold = UIFont(name: "StagSans-Semibold", size: 1)!
        let semiboldItalic = UIFont(name: "StagSans-SemiboldItalic", size: 1)!
        
        FontStyle.configFonts(
            largeTitle: book,
            title1: book,
            title2: book,
            title3: book,
            headline: book,
            subheadline: book,
            body: book,
            callout: book,
            footnote: book,
            caption1: book,
            caption2: book
        )
    }
    
}
