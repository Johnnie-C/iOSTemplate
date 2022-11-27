//
//  View+NavigationBarItems.swift
//  
//
//  Created by Xiaojun Cheng on 27/11/22.
//

import SwiftUI

public extension View {
    
    func leftItem(item: NavigationBarItem) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                barItem(for: item)
            }
        }
    }
    
    func rightItem(item: NavigationBarItem) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                barItem(for: item)
            }
        }
    }
    
    func leftItems(items: [NavigationBarItem]) -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                ForEach(items) {
                    barItem(for: $0)
                }
            }
        }
    }
    
    func rightItems(items: [NavigationBarItem]) -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ForEach(items) {
                    barItem(for: $0)
                }
            }
        }
    }
    
    private func barItem(for item: NavigationBarItem) -> some View {
        var font: FontStyle
        var color: Colors
        switch item.style {
        case .plain:
            font = .navigationBarPlainButtonTextColor
            color = .navigationBarPlainButtonTextColor
        case .done:
            font = .navigationBarDoneButtonTextColor
            color = .navigationBarDoneButtonTextColor
        case .back:
            font = .navigationBarBackButtonTextColor
            color = .backgroundColor
        }
        
        return ImageButton(
            title: item.title,
            font: font,
            icon: item.icon,
            color: item.tintColor ?? color,
            padding: .zero,
            action: item.action
        )
    }

}

public struct NavigationBarItem: Identifiable {
    
    public enum Style {
        case plain
        case done
        case back
    }
    
    public let id = UUID()
    let title: String?
    let icon: Icons?
    let style: Style
    let tintColor: Colors?
    let action: () -> Void
    
    /// init NavigationBarItem
    /// - Parameters:
    ///   - title: optional button title
    ///   - image: optional icon
    ///   - style: style
    ///   - tintColor: custom tint color.
    ///                If not provided, will use UINavigationBar button text color according to the style, which is configured through `UINavigationBar.configTabBar(plainButtonAttributes:doneButtonAttributes:backButtonAttributes:)`
    ///                If `plainButtonAttributes` is not configured, will use default system tint color
    ///   - action: action
    public init(
        title: String? = nil,
        icon: Icons? = nil,
        style: Style = .plain,
        tintColor: Colors? = nil,
        action: @escaping () -> Void)
    {
        self.title = title
        self.icon = icon
        self.style = style
        self.tintColor = tintColor
        self.action = action
    }
    
}
