//
//  UIEdgeInsets+Common.swift
//  
//
//  Created by Xiaojun Cheng on 25/11/22.
//

import UIKit

public extension UIEdgeInsets {
    
    init(
        top: CommonSpacing,
        left: CommonSpacing,
        bottom: CommonSpacing,
        right: CommonSpacing
    ) {
        self.init(
            top: top.rawValue,
            left: left.rawValue,
            bottom: bottom.rawValue,
            right: right.rawValue
        )
    }

}
