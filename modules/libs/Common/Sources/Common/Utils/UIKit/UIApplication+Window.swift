// **********************************************************
//    Copyright © 2025 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public extension UIApplication {
    
    var keyWindow: UIWindow? {
        return connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}
