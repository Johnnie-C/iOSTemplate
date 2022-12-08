//
//  OnLoadingModifier.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 1/11/21.
//

import SwiftUI

public extension View {

    func withLoadingHandler(
        isLoading: Binding<Bool>
    ) -> some View {
        modifier(
            OnLoadingModifier(isLoading: isLoading)
        )
    }

}


private struct OnLoadingModifier: ViewModifier {

    @Binding var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                LoadingView()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(.bottom, 40)
            }
        }
    }

}
