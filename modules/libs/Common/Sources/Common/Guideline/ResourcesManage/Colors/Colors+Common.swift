//
//  Colors+Common.swift
//  
//
//  Created by Xiaojun Cheng on 27/11/22.
//

import UIKit

extension Colors {
    
    static var navigationBarPlainButtonTextColor: Colors {
        guard
            let color = UINavigationBar.appearance()
                .standardAppearance
                .buttonAppearance
                .normal
                .titleTextAttributes[.foregroundColor] as? UIColor
        else {
            return .custom(.systemTintColor)
        }
        
        return .custom(color)
    }
    
    static var navigationBarBackButtonTextColor: Colors {
        guard
            let color = UINavigationBar.appearance()
                .standardAppearance
                .backButtonAppearance
                .normal
                .titleTextAttributes[.foregroundColor] as? UIColor
        else {
            return .custom(.systemTintColor)
        }
        
        return .custom(color)
    }
    
    static var navigationBarDoneButtonTextColor: Colors {
        guard
            let color = UINavigationBar.appearance()
                .standardAppearance
                .doneButtonAppearance
                .normal
                .titleTextAttributes[.foregroundColor] as? UIColor
        else {
            return .custom(.systemTintColor)
        }
        
        return .custom(color)
    }

}