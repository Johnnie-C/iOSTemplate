// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import SwiftUI
import NVActivityIndicatorView

public struct LoadingView: UIViewRepresentable {

    public typealias UIViewType = UIView
    private let type: NVActivityIndicatorType
    private let padding: CommonSpacing
    private let backgroundColor: Colors
    private let tintColor: Colors
    private let opacity: Double
    
    init(
        type: NVActivityIndicatorType = .circleStrokeSpin,
        backgroundColor: Colors = .custom(.clear),
        tintColor: Colors = .primaryColor,
        padding: CommonSpacing = .zero,
        opacity: Double = 1.0
    ) {
        self.type = type
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.padding = padding
        self.opacity = opacity
    }

    public func makeUIView(context: Context) -> UIView {
        let loadingView = NVActivityIndicatorView(
            frame: .zero,
            type: type,
            color: tintColor.uiColor(),
            padding: 0
        )
        
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 5
        
        // padding + 1 to avoid the iamge being cut, believe this is a bug in NVActivityIndicatorView
        var padding = padding.rawValue
        if padding == 0 {
            padding += 1
        }
        loadingView.padding = padding
        
        loadingView.backgroundColor = backgroundColor.uiColor(opacity)
        loadingView.startAnimating()

        let view = UIView(frame: .zero)
        view.wrap(subview: loadingView)

        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {

    }

}
