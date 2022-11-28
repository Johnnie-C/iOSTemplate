//
//  ImageButton.swift
//  
//
//  Created by Xiaojun Cheng on 25/11/22.
//

import SwiftUI

public struct ImageButton: View {
    
    private let title: String?
    private let font: FontStyle
    private let icon: Icons?
    private let padding: EdgeInsets
    private let iconPadding: CommonSpacing
    private let color: Color
    private let staticSize: Bool
    private let action: () -> Void
    @State private var height: CGFloat = 0
    
    public init(
        title: String? = nil,
        font: FontStyle = .body(),
        icon: Icons? = nil,
        color: Colors = .primaryLabel,
        padding: EdgeInsets = .defaultImageButtonPadding,
        iconPadding: CommonSpacing = .small,
        staticSize: Bool = false,
        action: @escaping () -> Void
    ) {
        self.init(
            title: title,
            font: font,
            icon: icon,
            color: color.dynamicColor(),
            padding: padding,
            iconPadding: iconPadding,
            staticSize: staticSize,
            action: action
        )
    }
    
    public init(
        title: String?,
        font: FontStyle = .body(),
        icon: Icons? = nil,
        color: Color = Colors.primaryLabel.dynamicColor(),
        padding: EdgeInsets = .defaultImageButtonPadding,
        iconPadding: CommonSpacing = .small,
        staticSize: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.font = font
        self.icon = icon
        self.color = color
        self.padding = padding
        self.iconPadding = iconPadding
        self.staticSize = staticSize
        self.action = action
    }
    
    private var iconSize: CGSize {
        guard let icon = icon?.image() else { return .zero }
        
        let ratio = icon.size.height / icon.size.width
        let fontSize = font.dynamicUIFont.pointSize
        let height = fontSize + CommonSize.xxxSmall.rawValue * 2
        let maxHeight = min(height, self.height - padding.top - padding.bottom)
        let width = maxHeight / ratio
        
        return CGSize(width: width, height: maxHeight)
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(alignment: .center, commonSpacing: .zero) {
                if let icon = icon {
                    Image(icon)
                        .resizable()
                        .setColor(color)
                        .scaledToFit()
                        .frame(size: iconSize)
                        .padding(.trailing, iconPadding)
                }
                
                if let title = title {
                    Text(
                        title,
                        font: font.dynamicFont,
                        color: color,
                        staticSize: staticSize
                    )
                }
            }
        }
        .standardHeight()
        .padding(padding)
        .observeFrame(in: .local) { frame in
            DispatchQueue.main.async {
                height = frame.size.height
            }
        }
    }

}

public extension EdgeInsets {
    
    static let defaultImageButtonPadding = EdgeInsets(
        top: .xSmall,
        leading: .small,
        bottom: .xSmall,
        trailing: .small
    )
        
}
