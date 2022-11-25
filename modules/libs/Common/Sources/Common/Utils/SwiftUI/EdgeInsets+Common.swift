//
//  UIEdgeInsets+Common.swift
//  
//
//  Created by Xiaojun Cheng on 25/11/22.
//

import SwiftUI

public extension EdgeInsets {
    
    init(
        top: CommonSpacing,
        leading: CommonSpacing,
        bottom: CommonSpacing,
        trailing: CommonSpacing
    ) {
        self.init(
            top: top.rawValue,
            leading: leading.rawValue,
            bottom: bottom.rawValue,
            trailing: trailing.rawValue
        )
    }

}
