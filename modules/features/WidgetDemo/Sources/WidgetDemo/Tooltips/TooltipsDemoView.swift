// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

public struct TooltipsDemoView: View {
    
    @State var showingAlert = false
    @State var alertMessage = ""
    
    @State var safariViewURL: URL? = nil
    @State var navigateToSafariView = false
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, commonSpacing: .large) {
                AttributedTextView(
                    attributedText: "A demo for how to use AttributedTextView. See details in TooltipsDemoView."
                        .styled()
                        .lineSpacing(.standard)
                        .font(
                            .body(weight: .semibold), 
                            text: "AttributedTextView"
                        )
                        .font(
                            .body(weight: .semibold),
                            text: "TooltipsDemoView"
                        )
                )
                
                AttributedTextView(
                    attributedText: "This demo also includes the usage of NSAttributedString extension."
                        .styled()
                        .lineSpacing(.standard)
                        .font(
                            .body(weight: .semibold),
                            text: "NSAttributedString"
                        )
                )
                
                Text(
                    "Tap on the icon to see tooltip.",
                     fontStyle: .body()
                )
                
                AttributedTextView(
                    attributedText: "Kern expanded text with tooltip {?:This is message for tooltip} at middle."
                        .styled()
                        .kern(.expanded),
                    tooltipTappedAction: { str in
                        alertMessage = str
                        showingAlert = true
                    }
                )
                
                AttributedTextView(
                    attributedText: "Text with multiple tooltips {?:This is message for tooltip}"
                        .styled()
                        +
                        " and with a custom icon {?:This is message for icon}."
                        .attributed()
                        .font(.body(weight: .light, italic: true))
                        .color(.warningYellow),
                    tooltipIcon: TooltipIcon(
                        icon: Icons.warnings.uiImage(.errorRed),
                        padding: .zero)
                    ,
                    tooltipTappedAction: { str in
                        alertMessage = str
                        showingAlert = true
                    }
                )
                
                AttributedTextView(
                    attributedText: "Text with {?:This is message for tooltip} tooltip with another text Google and a link Google."
                        .attributed()
                        .font(.body())
                        .link(
                            text: "Google",
                            withUrl: "https://www.google.co.nz",
                            indexes: [1]
                        ),
                    tooltipTappedAction: { str in
                        alertMessage = str
                        showingAlert = true
                    },
                    linkTappedAction: { label, url in
                        safariViewURL = url
                        navigateToSafariView = true
                        return false
                    }
                )
            }
            .padding(.medium)
        }
        .fillParent()
        .navigationTitle("Tooltips Demo")
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(""), 
                message: Text(alertMessage),
                dismissButton: .default(Text("Ok"))
            )
        }
        .sheet(isPresented: $navigateToSafariView) {
            SafariView(url: $safariViewURL)
        }
    }
    
}
