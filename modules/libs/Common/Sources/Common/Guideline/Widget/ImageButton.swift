//
//  ImageButton.swift
//  
//
//  Created by Xiaojun Cheng on 25/11/22.
//

import SwiftUI

public struct ImageButton: View {
    
    private let text: String
    private let fontStyle: FontStyle
    private let icon: UIImage?
    private let iconPadding: EdgeInsets
    private let color: Color
    private let staticSize: Bool
    private let action: () -> Void
    @State private var height: CGFloat = 0
    
    public init(
        _ text: String,
        fontStyle: FontStyle,
        icon: Icons? = nil,
        iconPadding: EdgeInsets = .defaultIconPadding,
        color: Colors = .primaryLabel,
        staticSize: Bool = false,
        action: @escaping () -> Void
    ) {
        self.init(
            text,
            fontStyle: fontStyle,
            icon: icon?.image(),
            iconPadding: iconPadding,
            color: color.dynamicColor(),
            staticSize: staticSize,
            action: action
        )
    }
    
    public init(
        _ text: String,
        fontStyle: FontStyle,
        icon: UIImage? = nil,
        iconPadding: EdgeInsets = .defaultIconPadding,
        color: Color = Colors.primaryLabel.dynamicColor(),
        staticSize: Bool = false,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.fontStyle = fontStyle
        self.icon = icon
        self.iconPadding = iconPadding
        self.color = color
        self.staticSize = staticSize
        self.action = action
    }
    
    private var iconSize: CGSize {
        CGSize(
            width: max(height - iconPadding.top - iconPadding.bottom, 0),
            height: max(height - iconPadding.top - iconPadding.bottom, 0)
        )
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(alignment: .center, commonSpacing: .zero) {
                if let icon = icon {
                    Image(uiImage: icon)
                        .resizable()
                        .setColor(color)
                        .frame(size: iconSize)
                        .padding(iconPadding)
                }
                
                Text(
                    text,
                    font: fontStyle.dynamicFont,
                    color: color,
                    staticSize: staticSize
                )
            }
        }
        .standardHeight()
        .paddingHorizontal(.small)
        .observeFrame(in: .local) { frame in
            DispatchQueue.main.async {
                height = frame.size.height
            }
        }
    }

}

public extension EdgeInsets {
    
    static let defaultIconPadding = EdgeInsets(
        top: .xSmall,
        leading: .zero,
        bottom: .xSmall,
        trailing: .small
    )
        
}
