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
    private let icon: UIImage?
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
            icon: icon?.image(),
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
        icon: UIImage? = nil,
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
        CGSize(
            width: max(height - padding.top - padding.bottom, 0),
            height: max(height - padding.top - padding.bottom, 0)
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
