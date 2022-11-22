//
//  SDWebImage+Common.swift
//  
//
//  Created by Johnnie Cheng on 17/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

public extension WebImage {
    
    func placeholder(_ icon: Icons) -> WebImage {
        placeholder(Image(uiImage: icon.image()))
    }
    
    func setSize(_ size: CommonSize) -> some View {
        setSize(
            CGSize(width: size.rawValue, height: size.rawValue)
        )
    }
    
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
