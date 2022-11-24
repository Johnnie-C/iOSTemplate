//
//  UINavigationBar+Config.swift
//  
//
//  Created by Xiaojun Cheng on 24/11/22.
//

import UIKit

public extension UINavigationBar {
    
    enum BackgroundStyle {
        /// equals to configureWithOpaqueBackground()
        case `default`
        
        /// equals to configureWithOpaqueBackground()
        case opaque
        
        /// equals to configureWithTransparentBackground()
        case transparent
    }
    
    struct TitleTextAttributes {
        
        let font: UIFont?
        let color: UIColor?
        
        public init(
            font: UIFont? = nil,
            color: UIColor? = nil
        ) {
            self.font = font
            self.color = color
        }
        
    }
    
    
    /// config navigation bar style
    /// - Parameters:
    ///   - backgroundColor: backgroundColor
    ///   - backgroundStyle: backgroundStyle see UITabBar.BackgroundStyle
    ///   - tintColor: back button color and bar item color
    ///   - titleAttributes: title text attributes
    ///   - largeTitleAttributes: large title text attributes
    ///   - plainButtonAttributes: plain bar button style
    ///   - doneButtonAttributes: done bar button style
    ///   - backButtonAttributes: back bar button style
    ///   - shadowColor: shadow color, pass same color as backgroundColor to hide shadow
    ///   - shadowImage: shadow image
    static func configTabBar(
        backgroundColor: UIColor? = nil,
        backgroundStyle: BackgroundStyle = .default,
        tintColor: UIColor? = nil,
        titleAttributes: TitleTextAttributes = .init(),
        largeTitleAttributes: TitleTextAttributes = .init(),
        plainButtonAttributes: TitleTextAttributes = .init(),
        doneButtonAttributes: TitleTextAttributes = .init(),
        backButtonAttributes: TitleTextAttributes = .init(),
        shadowColor: UIColor? = nil,
        shadowImage: UIImage? = nil
    ) {
        let navigationBar = UINavigationBar.appearance()
        let navigationBarAppearance = UINavigationBarAppearance()
        
        switch backgroundStyle {
        case .default:
            navigationBarAppearance.configureWithDefaultBackground()
        case .opaque:
            navigationBarAppearance.configureWithOpaqueBackground()
        case .transparent:
            navigationBarAppearance.configureWithTransparentBackground()
        }
        
        if let backgroundColor = backgroundColor {
            navigationBarAppearance.backgroundColor = backgroundColor
            navigationBar.barTintColor = backgroundColor
        }
        if let tintColor = tintColor {
            navigationBar.tintColor = tintColor
        }
        if let shadowImage = shadowImage {
            navigationBarAppearance.shadowImage = shadowImage
        }
        if let shadowColor = shadowColor {
            navigationBarAppearance.shadowColor = shadowColor
        }
        
        // title
        var titleTextAttributes = [NSAttributedString.Key : Any]()
        if let color = titleAttributes.color {
            titleTextAttributes[.foregroundColor] = color
        }
        if let font = titleAttributes.font {
            titleTextAttributes[.font] = font
        }
        navigationBarAppearance.titleTextAttributes = titleTextAttributes
        
        // large title
        var largeTitleTextAttributes = [NSAttributedString.Key : Any]()
        if let color = largeTitleAttributes.color {
            largeTitleTextAttributes[.foregroundColor] = color
        }
        if let font = largeTitleAttributes.font {
            largeTitleTextAttributes[.font] = font
        }
        navigationBarAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        
        // plain bar button
        let plainButtonAppearance = UIBarButtonItemAppearance()
        var plainButtonTextAttributes = [NSAttributedString.Key : Any]()
        if let color = plainButtonAttributes.color {
            plainButtonTextAttributes[.foregroundColor] = color
        }
        if let font = plainButtonAttributes.font {
            plainButtonTextAttributes[.font] = font
        }
        plainButtonAppearance.normal.titleTextAttributes = plainButtonTextAttributes
        plainButtonAppearance.highlighted.titleTextAttributes = plainButtonTextAttributes
        navigationBarAppearance.buttonAppearance = plainButtonAppearance
        
        // done bar button
        let doneButtonAppearance = UIBarButtonItemAppearance()
        var doneButtonTextAttributes = [NSAttributedString.Key : Any]()
        if let color = doneButtonAttributes.color {
            doneButtonTextAttributes[.foregroundColor] = color
        }
        if let font = doneButtonAttributes.font {
            doneButtonTextAttributes[.font] = font
        }
        doneButtonAppearance.normal.titleTextAttributes = doneButtonTextAttributes
        doneButtonAppearance.highlighted.titleTextAttributes = doneButtonTextAttributes
        navigationBarAppearance.doneButtonAppearance = doneButtonAppearance
        
        // back bar button
        let backButtonAppearance = UIBarButtonItemAppearance()
        var backButtonTextAttributes = [NSAttributedString.Key : Any]()
        if let color = backButtonAttributes.color {
            backButtonTextAttributes[.foregroundColor] = color
        }
        if let font = backButtonAttributes.font {
            backButtonTextAttributes[.font] = font
        }
        backButtonAppearance.normal.titleTextAttributes = backButtonTextAttributes
        backButtonAppearance.highlighted.titleTextAttributes = backButtonTextAttributes
        navigationBarAppearance.backButtonAppearance = backButtonAppearance

        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

}
