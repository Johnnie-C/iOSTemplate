//
//  Image+Common.swift
//  
//
//  Created by Johnnie Cheng on 24/10/22.
//

import SwiftUI

public extension Image {
    
    init(templateIcon icon: Icons) {
        self.init(uiImage: icon.templateImage())
    }
    
    init(_ icon: Icons) {
        switch icon {
        case .system(let name):
            self.init(systemName: name)
        default:
            self.init(uiImage: icon.image())
        }
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
