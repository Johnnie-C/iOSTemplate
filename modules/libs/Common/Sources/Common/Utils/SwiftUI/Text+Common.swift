// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension Text {
    
    init(_ text: String,
         fontStyle: FontStyle,
         color: Colors = .primaryLabel,
         opacity: Double = 1
    ) {
        self.init(
            text,
            font: fontStyle.dynamicFont,
            color: color.dynamicColor(opacity)
        )
    }
    
    init(_ text: String,
         font: Font,
         color: Color = Colors.primaryLabel.dynamicColor()
    ) {
        self.init(text)
        
        self = self.foregroundColor(color)
            .font(font)
    }
    
}

public extension Text {
    
    func lineSpacing(_ lineSpacing: LineSpacing) -> some View {
        self.lineSpacing(lineSpacing.rawValue)
    }
    
    func font(_ fontStyle: FontStyle, dynamicFont: Bool = true) -> Text {
        self.font(dynamicFont ? fontStyle.dynamicFont : fontStyle.staticFont)
    }
    
}
