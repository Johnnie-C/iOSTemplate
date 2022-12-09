// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import AlertToast

public extension View {

    func alertMessage(
        alertMessage: Binding<AlertMessage?>
    ) -> some View {
        modifier(AlertModifier(alertMessage: alertMessage))
    }

}

private struct AlertModifier: ViewModifier {

    @Binding var alertMessage: AlertMessage?
    @State private var isPresenting = false
    
    func body(content: Content) -> some View {
        content.toast(
            isPresenting: $isPresenting,
            duration: 2,
            tapToDismiss: true
        ) {
            return  AlertToast(
                displayMode: alertMessage?.alertMode.displayMode ?? .alert,
                type: alertMessage?.alertStyle.alertType ?? .regular,
                title: alertMessage?.title,
                subTitle: alertMessage?.message
            )
        }
        .onChange(of: alertMessage) { alertMessage in
            self.alertMessage = alertMessage
            self.isPresenting = alertMessage != nil
        }
    }

}

public struct AlertMessage: Equatable {

    let title: String?
    let message: String?
    let alertMode: AlertMode
    let alertStyle: AlertStyle
    
    public init(
        title: String? = nil,
        message: String? = nil,
        alertMode: AlertMode = .alert,
        alertStyle: AlertStyle = .regular
    ) {
        self.title = title
        self.message = message
        self.alertMode = alertMode
        self.alertStyle = alertStyle
    }
    
}

public enum AlertMode: Equatable {
    ///Present at the center of the screen
    case alert
    ///Drop from the top of the screen
    case hud
    ///Banner from the bottom of the view
    case banner(_ transition: BannerAnimation)
    
    public enum BannerAnimation{
        case slide, pop
        var bannaAnimation: AlertToast.BannerAnimation {
            switch self {
            case .slide: return .slide
            case .pop: return .pop
            }
        }
    }
    
    var displayMode: AlertToast.DisplayMode {
        switch self {
        case .alert: return .alert
        case .hud: return .hud
        case .banner(let animation): return .banner(animation.bannaAnimation)
        }
    }
}

/// Determine what the alert will display
public enum AlertStyle: Equatable {
    ///Animated checkmark
    case complete(_ color: Color)
    ///Animated xmark
    case error(_ color: Color)
    ///System image from `SFSymbols`
    case systemImage(_ name: String, _ color: Color)
    ///Image from Assets
    case image(_ name: String, _ color: Color)
    ///Loading indicator (Circular)
    case loading
    ///Only text alert
    case regular
    
    var alertType: AlertToast.AlertType {
        switch self {
        case .complete(let color): return .complete(color)
        case .error(let color): return .error(color)
        case .systemImage(let name, let color): return .systemImage(name, color)
        case .image(let name, let color): return .image(name, color)
        case .loading: return .loading
        case .regular: return .regular
        }
    }
}
