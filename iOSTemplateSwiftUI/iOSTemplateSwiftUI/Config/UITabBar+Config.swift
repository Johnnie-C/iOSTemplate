//
//  UITabBar+Config.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 22/11/22.
//

import UIKit
import Common

public extension UITabBar {
    
    enum BackgroundStyle {
        /// barStyle = .default OR configureWithOpaqueBackground() in iOS 15+
        /// isTranslucent = false
        case `default`
        
        /// barStyle = .black OR configureWithOpaqueBackground() in iOS 15+
        /// barStyle = .false
        case opaque
        
        /// barStyle = .black OR configureWithTransparentBackground() in iOS 15+
        /// barStyle = .true
        case transparent
    }
    
    static func configTabBar(
        backgroundColor: UIColor? = nil,
        tintColor: UIColor? = nil,
        backgroundStyle: BackgroundStyle = .default
    ) {
        let tabBarAppearance = UITabBarAppearance()
        switch backgroundStyle {
        case .default:
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().barStyle = .default
            UITabBar.appearance().isTranslucent = false
        case .opaque:
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().barStyle = .black
            UITabBar.appearance().isTranslucent = false
        case .transparent:
            tabBarAppearance.configureWithTransparentBackground()
            UITabBar.appearance().barStyle = .black
            UITabBar.appearance().isTranslucent = true
        }
        
        tabBarAppearance.backgroundColor = backgroundColor
        UITabBar.appearance().barTintColor = backgroundColor
        
        tabBarAppearance.selectionIndicatorTintColor = tintColor
        UITabBar.appearance().tintColor = tintColor
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = UIColor.green
        tabBarItemAppearance.selected.iconColor = UIColor.purple
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        UITabBar.appearance().unselectedItemTintColor = .green
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.green], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.purple], for: .normal)
        
        if #available(iOS 15.0, *) {
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }

}
