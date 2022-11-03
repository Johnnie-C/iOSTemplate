//
//  TextExtension.swift
//  
//
//  Created by Johnnie Cheng on 27/10/22.
//

import SwiftUI

public extension Text {
    
    init(_ text: String,
         font: Font, // TODO:
         color: Colors = .primaryLabel,
         opacity: Double = 1,
         staticSize: Bool = false
    ) {
        self.init(text, font: font, color: color.dynamicColor(opacity))
    }
    
    init(_ text: String,
         font: Font,
         color: Color = Colors.primaryLabel.dynamicColor(),
         staticSize: Bool = false
    ) {
        self.init(text)
        
        self = self.foregroundColor(color)
            .font(font)
    }
    
}
