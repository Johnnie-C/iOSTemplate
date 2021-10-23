//
//  ClassIdentifiable.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 17/10/21.
//

import Foundation

public protocol ClassIdentifiable: AnyObject {}

public extension ClassIdentifiable {

    static var identifier: String {
        return String(describing: self)
    }

}
