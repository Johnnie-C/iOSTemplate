// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import AlertToast

public extension View {

    func toastMessage(
        toastMessage: Binding<ToastMessage?>
    ) -> some View {
        modifier(ToastModifier(toastMessage: toastMessage))
    }

}

private struct ToastModifier: ViewModifier {

    @Binding var toastMessage: ToastMessage?
    @State private var isPresenting = false
    
    func body(content: Content) -> some View {
        content.toast(
            isPresenting: $isPresenting,
            duration: toastMessage?.duration ?? 2,
            tapToDismiss: true,
            alert: {
                return AlertToast(
                    displayMode: toastMessage?.toastMode.displayMode ?? .banner(.pop),
                    type: toastMessage?.toastStyle.toastType ?? .regular,
                    title: toastMessage?.title,
                    subTitle: toastMessage?.message
                )
            },
            onTap: {
                toastMessage?.onTap?()
            },
            completion: {
                toastMessage?.completion?()
            }
        )
        .onChange(of: toastMessage) { toastMessage in
            self.toastMessage = toastMessage
            self.isPresenting = toastMessage != nil
        }
    }

}

public struct ToastMessage: Equatable {
    
    let id = UUID()
    let title: String?
    let message: String?
    let toastMode: ToastMode
    let toastStyle: ToastStyle
    let duration: Double
    let onTap: (() -> Void)?
    let completion: (() -> Void)?
    
    public init(
        title: String? = nil,
        message: String? = nil,
        toastMode: ToastMode = .banner(.pop),
        toastStyle: ToastStyle = .regular,
        duration: Double = 2,
        onTap: (() -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.toastMode = toastMode
        self.toastStyle = toastStyle
        self.duration = duration
        self.onTap = onTap
        self.completion = completion
    }
    
    public static func == (lhs: ToastMessage, rhs: ToastMessage) -> Bool {
        lhs.id == rhs.id
    }
    
}

public enum ToastMode: Equatable {
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

/// Determine what the toast will display
public enum ToastStyle: Equatable {
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
    ///Only text toast
    case regular
    
    var toastType: AlertToast.AlertType {
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
