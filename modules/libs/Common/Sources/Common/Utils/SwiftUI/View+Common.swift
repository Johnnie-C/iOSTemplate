//
//  View+Common.swift
//  
//
//  Created by Johnnie Cheng on 21/10/22.
//

import SwiftUI

public extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    func hideNavigationBar() -> some View {
        return self
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
    
}


// MARK: - color
public extension View {
    
    func foregroundColor(_ color: Colors) -> some View {
        foregroundColor(color.dynamicColor())
    }
    
    func background(_ color: Colors) -> some View {
        background(color.dynamicColor())
    }
    
}

// MARK: - padding
public extension View {
    
    func paddingVertical(_ spacing: CommonSpacing) -> some View {
        padding([.top, .bottom], spacing.rawValue)
    }
    
    func paddingHorizontal(_ spacing: CommonSpacing) -> some View {
        padding([.leading, .trailing], spacing.rawValue)
    }
    
}

// MARK: - frame
public extension View {
    
    func standardHeight() -> some View {
        frame(height: CommonSize.standardHeight.rawValue)
    }
    
    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: size, height: size, alignment: alignment)
    }
    
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    func fillParent() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func fillWidth() -> some View {
        frame(maxWidth: .infinity)
    }
    
    func fillHeight() -> some View {
        frame(maxHeight: .infinity)
    }
    
}


// MARK: - RoundedCorner
public extension View {
    
    @ViewBuilder
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        if #available(iOS 15, *) {
            clipShape(RoundedCorner(radius: radius, corners: corners))
        } else {
            cornerRadius(radius)
        }
    }
    
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        return Path(path.cgPath)
    }
    
}
