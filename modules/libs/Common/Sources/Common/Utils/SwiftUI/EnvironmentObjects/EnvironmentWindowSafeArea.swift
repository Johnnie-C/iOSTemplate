// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension EnvironmentValues {
    
    var windowSafeArea: EdgeInsets {
        self[WindowSafeAreaInsetsKey.self]
    }
}

private struct WindowSafeAreaInsetsKey: EnvironmentKey {
    
    static var defaultValue: EdgeInsets {
        let safeArea = UIApplication.shared
            .keyWindow?
            .safeAreaInsets ?? .zero
        
        return safeArea.insets
    }
    
}
