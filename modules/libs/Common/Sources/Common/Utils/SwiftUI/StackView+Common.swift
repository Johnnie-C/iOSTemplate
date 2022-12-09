// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension HStack {
    
    init(
        alignment: VerticalAlignment = .center,
        commonSpacing: CommonSpacing,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: commonSpacing.rawValue,
            content: content
        )
    }
    
}

public extension VStack {
    
    init(
        alignment: HorizontalAlignment = .center,
        commonSpacing: CommonSpacing,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: commonSpacing.rawValue,
            content: content
        )
    }
    
}
