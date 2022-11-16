//
//  StackView+Common.swift
//  
//
//  Created by Johnnie Cheng on 16/11/22.
//

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
