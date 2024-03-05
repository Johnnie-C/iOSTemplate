// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public struct AnimatedCheckmarkView: View {
    
    public var animationDuration: Double = 0.75
    public var shouldScale = true
    public var size: CGSize = .init(width: 40, height: 40)
    public var innerShapeSizeRatio: CGFloat = 1 / 3
    public var fromColor: Colors = .successGreen
    public var toColor: Colors = .successGreen
    public var strokeStyle: StrokeStyle = .init(lineWidth: 2, lineCap: .round, lineJoin: .round)
    public var animateOnTap = true
    public var outerShape: AnyShape = .init(Circle())
    public var onAnimationFinish: (() -> Void)?
    
    @State private var outerTrimEnd: CGFloat = 0
    @State private var innerTrimEnd: CGFloat = 0
    @State private var strokeColor: Colors = .successGreen
    @State private var scale = 1.0
    
    public var body: some View {
        ZStack {
            outerShape
                .trim(from: 0.0, to: outerTrimEnd)
                .stroke(strokeColor.dynamicColor(), style: strokeStyle)
                .rotationEffect(.degrees(-90))
            
            Checkmark()
                .trim(from: 0, to: innerTrimEnd)
                .stroke(strokeColor.dynamicColor(), style: strokeStyle)
                .frame(
                    width: size.width * innerShapeSizeRatio,
                    height: size.height * innerShapeSizeRatio
                )
        }
        .frame(width: size.width, height: size.height)
        .scaleEffect(scale)
        .onAppear() {
            strokeColor = fromColor
            animate()
        }
        .onTapGesture {
            if animateOnTap {
                outerTrimEnd = 0
                innerTrimEnd = 0
                strokeColor = fromColor
                scale = 1
                animate()
            }
        }
    }
    
    func animate() {
        if shouldScale {
            withAnimation(
                .linear(duration: 0.4 * animationDuration)
            ) {
                outerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.4 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.7 * animationDuration)
            ) {
                strokeColor = toColor
                scale = 1.1
            }
            
            withAnimation(
                .linear(duration: 0.1 * animationDuration)
                .delay(0.9 * animationDuration)
            ) {
                scale = 1
            }
        } else {
            withAnimation(
                .linear(duration: 0.5 * animationDuration)
            ) {
                outerTrimEnd = 1.0
            }
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.5 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.8 * animationDuration)
            ) {
                strokeColor = toColor
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 2) {
            onAnimationFinish?()
        }
    }
    
}

struct Checkmark: Shape {
    
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        
        var path = Path()
        path.move(to: .init(x: 0 * width, y: 0.5 * height))
        path.addLine(to: .init(x: 0.4 * width, y: 1.0 * height))
        path.addLine(to: .init(x: 1.0 * width, y: 0 * height))
        
        return path
    }
    
}

public struct AnyShape: Shape {
    
    private var shape: any Shape
    
    public init(_ shape: any Shape) {
        self.shape = shape
    }
    
    public func path(in rect: CGRect) -> Path {
        return shape.path(in: rect)
    }
    
}
