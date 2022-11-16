//
//  String+Product.swift
//  
//
//  Created by Johnnie Cheng on 16/11/22.
//

import Foundation
import Common

extension String {
    
    var localized: String {
        localizedString(withKey: self, bundle: .productBundle)
    }
    
    func localizedWithFormat(_ arguments: CVarArg...) -> String {
        localizedString(withKey: self, bundle: .productBundle, arguments)
    }
    
}

