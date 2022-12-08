//
//  ImageButton.swift
//  
//
//  Created by Xiaojun Cheng on 25/11/22.
//

import SwiftUI

public struct ImageButton: View {
    
    public enum Style {
        case `default`
        case fillWidth
        case sized(_ size: CGSize)
    }
    
    public enum Status {
        case normal
        case loading
        case success(onComplete: (() -> Void)? = nil)
        case disabled
    }
    
    private let title: String?
    private let icon: Icons?
    private let status: Status
    private let config: Config
    private let action: () -> Void
    @State private var size = CGSize.zero
    
    public init(
        title: String? = nil,
        icon: Icons? = nil,
        status: Status = .normal,
        config: Config = .init(),
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.status = status
        self.config = config
        self.action = action
    }
    
    private var iconSize: CGSize {
        let fontSize = config.font.dynamicUIFont.pointSize
        let height = fontSize + CommonSize.xxxSmall.rawValue * 2 - config.padding.top - config.padding.bottom
        
        return CGSize(
            width: max(height, fontSize),
            height: max(height, fontSize)
        )
    }
    
    private var buttonTintColor: Color {
        if case .disabled = status {
            return Colors.disabledTextColor.dynamicColor()
        } else {
            return config.tintColor.dynamicColor()
        }
    }
    
    private var buttonDisabled: Bool {
        if case .normal = status { return false }
        return true
    }
    
    public var body: some View {
        Button {
            guard case .normal = status else { return }
            action()
        } label: {
            VStack {
                switch status {
                case .normal, .disabled:
                    buttonView
                case .loading:
                    loadingView
                case .success:
                    successTickView
                }
            }
            
        }
        .observeFrame(in: .global) { frame in
            DispatchQueue.main.async {
                switch self.status {
                case .normal, .disabled:
                    size = frame.size
                default:
                    break
                }
            }
        }
        .disabled(buttonDisabled)
        .background(backgroundView())
    }
    
    private var buttonView: some View {
        HStack(alignment: .center, commonSpacing: .zero) {
            if let icon = icon {
                Image(icon)
                    .resizable()
                    .setColor(buttonTintColor)
                    .frame(size: iconSize)
                    .scaledToFit()
                    .padding(.trailing, config.iconPadding)
            }

            if let title = title {
                Text(
                    title,
                    font: config.font.dynamicFont,
                    color: buttonTintColor,
                    staticSize: config.staticSize
                )
            }
        }
        .padding(config.padding)
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        .frame(minHeight: minHeight)
    }
    
    private var loadingView: some View {
        VStack {
            let fontSize = config.font.dynamicUIFont.pointSize
            let height = fontSize + CommonSize.small.rawValue + 1
            
            LoadingView(tintColor: config.tintColor)
                .frame(width: height, height: height)
        }
        .frame(width: size.width, height: size.height)
    }
    
    private var successTickView: some View {
        VStack {
            let fontSize = config.font.dynamicUIFont.pointSize
            let height = fontSize + CommonSize.small.rawValue
            var completionBlock: (() -> Void)? = nil
            if case .success(let block) = status {
                completionBlock = block
            }
            
            return AnimatedCheckmarkView(
                size: .init(
                    width: height,
                    height: height
                ),
                fromColor: config.tintColor,
                onAnimationFinish: completionBlock
            )
            .frame(width: size.width, height: size.height)
        }
       
    }
    
    private func backgroundView() -> some View {
        ZStack {
            if let color = config.color?.dynamicColor() {
                color
                if case .disabled = status {
                    Colors.custom(.white).dynamicColor(0.65)
                }
            }
        }
    }
    
    private var maxWidth: CGFloat? {
        switch config.style {
        case .default:
            return nil
        case .fillWidth:
            return .infinity
        case .sized(let size):
            return size.width
        }
    }
    
    private var maxHeight: CGFloat? {
        let fontSize = config.font.dynamicUIFont.pointSize
        let height = fontSize + config.padding.top + config.padding.bottom //CommonSpacing.xSmall.rawValue * 2
        switch config.style {
        case .default:
            return height
        case .fillWidth:
            return height
        case .sized(let size):
            return size.height
        }
    }
    
    private var minHeight: CGFloat? {
        let standardHeight = CommonSize.standardHeight.rawValue
        switch config.style {
        case .default:
            return standardHeight
        case .fillWidth:
            return standardHeight
        case .sized(let size):
            return size.height
        }
    }

}

public extension ImageButton {
    
    struct Config {
        let style: Style
        let font: FontStyle
        let color: Colors?
        let tintColor: Colors
        let padding: EdgeInsets
        let iconPadding: CommonSpacing
        let staticSize: Bool
        
        public init(
            style: Style = .default,
            font: FontStyle = .body(),
            color: Colors? = nil,
            tintColor: Colors = .primaryLabel,
            padding: EdgeInsets = .defaultImageButtonPadding,
            iconPadding: CommonSpacing = .small,
            staticSize: Bool = false
        ) {
            self.style = style
            self.font = font
            self.color = color
            self.tintColor = tintColor
            self.padding = padding
            self.iconPadding = iconPadding
            self.staticSize = staticSize
        }
    }
    
}

public extension EdgeInsets {
    
    static let defaultImageButtonPadding = EdgeInsets(
        top: .xxSmall,
        leading: .small,
        bottom: .xxSmall,
        trailing: .small
    )
        
}
