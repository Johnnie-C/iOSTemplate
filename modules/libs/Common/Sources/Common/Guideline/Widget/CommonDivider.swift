//
//  CommonDivider.swift
//  
//
//  Created by Johnnie Cheng on 16/11/22.
//

import SwiftUI

public struct CommonDivider: View {
    
    public enum Thickness: CGFloat {
        case thin = 0.33
        case medium = 0.75
        case thick = 1.25
    }
    
    let color: Colors
    let thickness: Thickness
    
    public init(
        color: Colors = .divider,
        thickness: Thickness = .thin
    ) {
        self.color = color
        self.thickness = thickness
    }
    
    public var body: some View {
        Rectangle()
            .fill(color.dynamicColor())
            .frame(height: thickness.rawValue)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
}
