// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension EnvironmentValues {

    var screenSize: CGSize {
        get {
            self[ScreenSizeKey.self]
        }
        set {
            self[ScreenSizeKey.self] = newValue
        }
    }
    
}

struct ScreenSizeKey: EnvironmentKey {
    
    static let defaultValue: CGSize = UIScreen.main.bounds.size
    
}
