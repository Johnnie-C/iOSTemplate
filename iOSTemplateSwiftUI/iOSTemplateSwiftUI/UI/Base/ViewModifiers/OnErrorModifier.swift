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

    @State private var error: Error?
    @State private var hasError: Bool = false
    private var errorPublisher: Published<Error?>.Publisher
    private var onError: ((Error) -> ErrorMessage)?

    init(error: Published<Error?>.Publisher,
         onError: ((Error) -> ErrorMessage)? = nil)
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
            var title = localizedString(withKey: "alert.generalError.title")
            var message = localizedString(withKey: "alert.generalError.message")
            if let error = error,
               let errorMessage = onError?(error)
            {
                title = errorMessage.title ?? ""
                message = errorMessage.message ?? ""

            }

            return  AlertToast(displayMode: .hud,
                               type: .error(.red),
                               title: title,
                               subTitle: message)
        }
        .onReceive(errorPublisher) { error in
            self.error = error
            self.hasError = error != nil
        }
    }

}

extension View {

    func withErrorHandler(error: Published<Error?>.Publisher,
                          onError: ((Error) -> ErrorMessage)? = nil)
        -> some View
    {
        modifier(OnErrorModifier(error: error, onError: onError))
    }

}

struct ErrorMessage {

    let title: String?
    let message: String?
    
}
