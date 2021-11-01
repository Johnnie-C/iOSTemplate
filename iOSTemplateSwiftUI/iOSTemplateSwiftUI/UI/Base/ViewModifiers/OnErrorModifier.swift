//
//  OnErrorModifier.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 30/10/21.
//

import SwiftUI
import AlertToast
import Common

private struct OnErrorModifier: ViewModifier {

    @State private var hasError: Bool = false
    private var errorPublisher: Published<Error?>.Publisher
    private var onError: ((Error) -> Void)?

    init(error: Published<Error?>.Publisher,
         onError: ((Error) -> Void)? = nil)
    {
        self.errorPublisher = error
        self.onError = onError
    }

    func body(content: Content) -> some View {
        content
            .toast(isPresenting: $hasError,
                   duration: 2,
                   tapToDismiss: true)
        {
            AlertToast(
                displayMode: .hud,
                type: .error(.red),
                title: localizedString(withKey: "alert.generalError.title"),
                subTitle: localizedString(withKey: "alert.generalError.message")
            )
        }
        .onReceive(errorPublisher) { error in
            if let onError = self.onError {
                if let error = error {
                    onError(error)
                }
                return
            }

            self.hasError = error != nil
        }
    }

}

extension View {

    func withErrorHandler(error: Published<Error?>.Publisher,
                          onError: ((Error) -> Void)? = nil)
        -> some View
    {
        modifier(OnErrorModifier(error: error, onError: onError))
    }

}
