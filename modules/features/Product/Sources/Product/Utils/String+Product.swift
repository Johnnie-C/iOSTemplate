// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

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

