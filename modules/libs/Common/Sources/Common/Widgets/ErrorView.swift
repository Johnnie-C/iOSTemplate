// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public struct ErrorView: View {
    
    var title: String
    var description: String
    var retry: Retry?
    
    public init(
        title: String = "",
        description: String = "",
        retry: Retry? = nil
    ) {
        self.title = title
        self.description = description
        self.retry = retry
    }
    
    public var body: some View {
            ZStack {
                VStack(alignment: .center, spacing: 0) {
                    Image(templateIcon: .warnings)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .foregroundColor(.warningYellow)
                    
                    Text(title)
                        .font(.dynamicFont(.headline()))
                        .multilineTextAlignment(.center)
                        .padding(.top, .large)
                        .foregroundColor(.titleColor)
                    
                    Text(description)
                        .font(.dynamicFont(.body()))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, .medium)
                    
                    if let retry {
                        ImageButton(
                            title: retry.actionTitle,
                            status: retry.isLoading ? .loading : .normal,
                            config: .init(
                                style: .fillWidth,
                                shape: .rounded,
                                tintColor: .actionTitleColor
                            )
                        ) {
                            retry.isLoading = true
                            retry.action()
                        }
                        .padding(.horizontal, .large)
                        .padding(.top, .xLarge)
                    }
                }
            }
            .padding([.leading, .trailing], .large)
    }
    
    public struct Retry {
        
        @Binding var isLoading: Bool
        var actionTitle: String = "Try again"
        var action: (() -> Void)
        
        public init(
            isLoading: Binding<Bool>,
            actionTitle: String = "Try again",
            action: @escaping (() -> Void)
        ) {
            self._isLoading = isLoading
            self.actionTitle = actionTitle
            self.action = action
        }
        
    }
    
}
