//
//  ColletionExtension.swift
//  MegaBudget
//
//  Created by Johnnie Cheng on 30/4/21.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {

    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }

}
