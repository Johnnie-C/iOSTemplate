//
//  LoadingView.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 30/10/21.
//

import SwiftUI
import Common
import NVActivityIndicatorView

struct LoadingView: UIViewRepresentable {

    typealias UIViewType = UIView

    func makeUIView(context: Context) -> UIView {
        let loadingView = NVActivityIndicatorView(
            frame: .zero,
            type: .ballPulseSync,
            color: Colors.primaryColor.uiColor(),
            padding: 0
        )
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 5
        loadingView.padding = 20
        loadingView.backgroundColor = .black.withAlphaComponent(0.5)
        loadingView.startAnimating()

        let view = UIView(frame: .zero)
        view.wrap(subview: loadingView)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }

}
