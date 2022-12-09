// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public extension UIEdgeInsets {
    
    init(
        top: CommonSpacing,
        left: CommonSpacing,
        bottom: CommonSpacing,
        right: CommonSpacing
    ) {
        self.init(
            top: top.rawValue,
            left: left.rawValue,
            bottom: bottom.rawValue,
            right: right.rawValue
        )
    }

}
