// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    func leftItem(item: NavigationBarItem?) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if let item = item {
                    barItem(for: item)
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    func rightItem(item: NavigationBarItem?) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let item = item {
                    barItem(for: item)
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    func leftItems(items: [NavigationBarItem]?) -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                if let items = items {
                    ForEach(items) {
                        barItem(for: $0)
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    func rightItems(items: [NavigationBarItem]?) -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if let items = items {
                    ForEach(items) {
                        barItem(for: $0)
                    }
                } else {
                    EmptyView()
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
            icon: item.icon,
            config: .init(
                font: font,
                tintColor: item.tintColor ?? color,
                padding: .zero,
                iconPadding: .xxSmall
            ),
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
