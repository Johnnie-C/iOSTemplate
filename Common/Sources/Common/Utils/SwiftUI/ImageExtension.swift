//
//  ImageExtension.swift
//  
//
//  Created by Johnnie Cheng on 24/10/22.
//

import SwiftUI

public extension Image {
    
    func setSize(_ size: CGSize) -> some View {
        self.resizable()
            .frame(size: size)
    }
    
    func setColor(_ color: Color) -> some View {
        self.renderingMode(.template)
            .foregroundColor(color)
    }
    
    func setColor(_ color: Colors, opacity: Double = 1) -> some View {
        self.renderingMode(.template)
            .foregroundColor(color.dynamicColor(opacity))
    }

}
