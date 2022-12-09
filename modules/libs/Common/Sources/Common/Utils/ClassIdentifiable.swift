// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation

public protocol ClassIdentifiable: AnyObject {}

public extension ClassIdentifiable {

    static var identifier: String {
        return String(describing: self)
    }

}
