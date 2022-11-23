//
//  UITabBar+Config.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 22/11/22.
//

import UIKit

public extension UITabBar {
    
    enum BackgroundStyle {
        /// equals to configureWithOpaqueBackground()
        case `default`
        
        /// equals to configureWithOpaqueBackground()
        case opaque
        
        /// equals to configureWithTransparentBackground()
        case transparent
    }
    
    struct ItemStyle {
        
        let iconColor: UIColor?
        let textColor: UIColor?
        let font: UIFont?
        let badgeColor: UIColor?
        
        public init(
            iconColor: UIColor? = nil,
            textColor: UIColor? = nil,
            font: UIFont? = nil,
            badgeColor: UIColor? = nil
        ) {
            self.iconColor = iconColor
            self.textColor = textColor
            self.font = font
            self.badgeColor = badgeColor
        }
        
    }
    
    static func configTabBar(
        backgroundColor: UIColor? = nil,
        backgroundStyle: BackgroundStyle = .default,
        selectedItemStyle: ItemStyle = ItemStyle(),
        unselectedItemStyle: ItemStyle = ItemStyle(),
        shadowImage: UIImage? = nil,
        shadowColor: UIColor? = nil
    ) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = backgroundColor
        
        switch backgroundStyle {
        case .default:
            tabBarAppearance.configureWithDefaultBackground()
        case .opaque:
            tabBarAppearance.configureWithOpaqueBackground()
        case .transparent:
            tabBarAppearance.configureWithTransparentBackground()
        }
        
        if let shadowImage = shadowImage {
            tabBarAppearance.shadowImage = shadowImage
        }
        if let shadowColor = shadowColor {
            tabBarAppearance.shadowColor = shadowColor
        }
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        var selectedTitleTextAttributes = [NSAttributedString.Key : Any]()
        var unselectedTitleTextAttributes = [NSAttributedString.Key : Any]()
        
        // selected item
        if let iconColor = selectedItemStyle.iconColor {
            tabBarItemAppearance.selected.iconColor = iconColor
        }
        if let textColor = selectedItemStyle.textColor {
            selectedTitleTextAttributes[.foregroundColor] = textColor
        }
        if let font = selectedItemStyle.font {
            selectedTitleTextAttributes[.font] = font
        }
        if let badgeColor = selectedItemStyle.badgeColor {
            tabBarItemAppearance.selected.badgeBackgroundColor = badgeColor
        }
        
        // unselected item
        if let iconColor = unselectedItemStyle.iconColor {
            tabBarItemAppearance.normal.iconColor = iconColor
        }
        if let textColor = unselectedItemStyle.textColor {
            unselectedTitleTextAttributes[.foregroundColor] = textColor
        }
        if let font = unselectedItemStyle.font ?? selectedItemStyle.font {
            unselectedTitleTextAttributes[.font] = font
        }
        if let badgeColor = unselectedItemStyle.badgeColor ?? selectedItemStyle.badgeColor {
            tabBarItemAppearance.normal.badgeBackgroundColor = badgeColor
        }
        
        tabBarItemAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
        tabBarItemAppearance.normal.titleTextAttributes = unselectedTitleTextAttributes
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }

}
