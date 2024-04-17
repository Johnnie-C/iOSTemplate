// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import SafariServices

public struct SafariView: View {
    
    @Binding var url: URL?
    
    public init(url: Binding<URL?>) {
        self._url = url
    }
    
    public var body: some View {
        VStack {
            if let url {
                SafariWebView(url: url)
            } else {
                EmptyView()
            }
            
        }
        .fillParent()
        .background(.backgroundColor)
    }
    
}

struct SafariWebView: UIViewControllerRepresentable {
    
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    public func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: Context
    ) {
        
    }
    
}
