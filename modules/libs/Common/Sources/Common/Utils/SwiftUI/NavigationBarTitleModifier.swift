// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    func navigationTitle(
        title: String,
        hideBackButtonTitleOnNextView: Bool = false
    ) -> some View {
        modifier(
            NavigationBarTitleModifier(
                title: title,
                hideBackButtonTitleOnNextView: hideBackButtonTitleOnNextView
            )
        )
    }
    
}

public struct NavigationBarTitleModifier: ViewModifier {
    
    private var title: String
    private var hideBackButtonTitleOnNextView: Bool
    @State private var hideTitle: Bool = false
    
    init(
        title: String,
        hideBackButtonTitleOnNextView: Bool = false
    ) {
        self.title = title
        self.hideBackButtonTitleOnNextView = hideBackButtonTitleOnNextView
    }

    public func body(content: Content) -> some View {
        content
            .navigationTitle(hideTitle ? title : "")
            .onAppear {
                if hideBackButtonTitleOnNextView {
                    hideTitle = true
                }
            }
            .onDisappear {
                hideTitle = false
            }
    }
}
