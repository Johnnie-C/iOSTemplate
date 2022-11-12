//
//  OnLoadingModifier.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 1/11/21.
//

import SwiftUI
import Common

private struct OnLoadingModifier: ViewModifier {

    @State private var isLoading: Bool = false
    private var isLoadingPublisher: Published<Bool>.Publisher
    private var onLoading: ((Bool) -> Void)?

    init(
        isLoading: Published<Bool>.Publisher,
        onLoading: ((Bool) -> Void)? = nil
    ) {
        self.isLoadingPublisher = isLoading
        self.onLoading = onLoading
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                LoadingView()
                    .frame(width: 75, height: 75, alignment: .center)
                    .padding(.bottom, 60)
            }
        }
        .onReceive(isLoadingPublisher) { isLoading in
            if let onLoading = self.onLoading {
                onLoading(isLoading)
                return
            }
            
            self.isLoading = isLoading
        }
    }

}

extension View {

    func withLoadingHandler(
        isLoading: Published<Bool>.Publisher,
        onLoading: ((Bool) -> Void)? = nil
    ) -> some View {
        modifier(
            OnLoadingModifier(
                isLoading: isLoading,
                onLoading: onLoading
            )
        )
    }

}
