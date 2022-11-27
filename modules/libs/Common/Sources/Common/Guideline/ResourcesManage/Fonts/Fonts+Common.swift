//
//  Fonts+Common.swift
//  
//
//  Created by Xiaojun Cheng on 27/11/22.
//

import UIKit

extension FontStyle {
    
    static var navigationBarPlainButtonTextColor: FontStyle {
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

    static var navigationBarBackButtonTextColor: FontStyle {
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
    
    static var navigationBarDoneButtonTextColor: FontStyle {
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
