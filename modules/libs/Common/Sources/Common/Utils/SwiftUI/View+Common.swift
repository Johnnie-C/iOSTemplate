// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

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
    
    func foregroundColor(
        _ color: Colors,
        opacity: Double = 1
    ) -> some View {
        foregroundColor(color.dynamicColor(opacity))
    }
    
    func background(
        _ color: Colors,
        opacity: Double = 1
    ) -> some View {
        background(color.dynamicColor(opacity))
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
    
    func padding(_ edges: Edge.Set = .all, _ spacing: CommonSpacing) -> some View {
        padding(edges, spacing.rawValue)
    }
    
    func padding(_ spacing: CommonSpacing) -> some View {
        padding(.all, spacing.rawValue)
    }
    
}

// MARK: - frame
public extension View {
    
    func height(size: CommonSize) -> some View {
        frame(height: size.rawValue)
    }
    
    func width(size: CommonSize) -> some View {
        frame(width: size.rawValue)
    }
    
    func standardHeight() -> some View {
        frame(height: CommonSize.standardHeight.rawValue)
    }
    
    func frame(size: CommonSize, alignment: Alignment = .center) -> some View {
        frame(width: size.rawValue, height: size.rawValue, alignment: alignment)
    }
    
    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: size, height: size, alignment: alignment)
    }
    
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    func fillParent(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func fillWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func fillHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
}


// MARK: - RoundedCorner
public extension View {
    
    @ViewBuilder
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
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
