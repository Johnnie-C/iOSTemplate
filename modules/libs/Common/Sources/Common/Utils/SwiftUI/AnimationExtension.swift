// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension Animation {
    
    static func lightSpringAnimation(duration: Double = 0.3) -> Animation {
        return .spring(duration: duration, bounce: 0.3, blendDuration: 0.2)
    }
    
    static func strongSpringAnimation(duration: Double = 0.3) -> Animation {
        return .spring(duration: duration, bounce: 0.5, blendDuration: 0.15)
    }

}
