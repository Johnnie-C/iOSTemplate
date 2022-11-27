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
    
    static let zero: EdgeInsets = {
        .init(
            top: CommonSpacing.zero,
            leading: CommonSpacing.zero,
            bottom: CommonSpacing.zero,
            trailing: CommonSpacing.zero
        )
    }()

}
