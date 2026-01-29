// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension EdgeInsets {
    
    init(
        top: CommonSpacing = .zero,
        leading: CommonSpacing = .zero,
        bottom: CommonSpacing = .zero,
        trailing: CommonSpacing = .zero
    ) {
        self.init(
            top: top.rawValue,
            leading: leading.rawValue,
            bottom: bottom.rawValue,
            trailing: trailing.rawValue
        )
    }
    
    static let zero: EdgeInsets = {
        .init(
            top: CommonSpacing.zero,
            leading: CommonSpacing.zero,
            bottom: CommonSpacing.zero,
            trailing: CommonSpacing.zero
        )
    }()

}

public extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
