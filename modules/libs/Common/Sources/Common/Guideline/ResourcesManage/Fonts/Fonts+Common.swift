// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

extension FontStyle {
    
    static var navigationBarPlainButtonTextFont: FontStyle {
        guard
            let font = UINavigationBar.appearance()
                .standardAppearance
                .buttonAppearance
                .normal
                .titleTextAttributes[.font] as? UIFont
        else {
            return .body()
        }
        
        return .custom(font)
    }

    static var navigationBarBackButtonTextFont: FontStyle {
        guard
            let font = UINavigationBar.appearance()
                .standardAppearance
                .backButtonAppearance
                .normal
                .titleTextAttributes[.font] as? UIFont
        else {
            return .body()
        }
        
        return .custom(font)
    }
    
    static var navigationBarDoneButtonTextFont: FontStyle {
        guard
            let font = UINavigationBar.appearance()
                .standardAppearance
                .doneButtonAppearance
                .normal
                .titleTextAttributes[.font] as? UIFont
        else {
            return .body()
        }
        
        return .custom(font)
    }
    
}
