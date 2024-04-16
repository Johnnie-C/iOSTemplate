// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI

public extension View {
    
    func shake(trigger: Bool) -> some View {
        modifier(Shake(trigger: trigger))
    }
    
}

fileprivate let duration: CGFloat = 0.3

struct Shake: ViewModifier {
    
    enum AnimationStatus {
        case idle
        case pending
        case animating
        
        var offsetX: CGFloat {
            switch self {
            case .idle:
                return 0
            case .pending:
                return -5
            case .animating:
                return 5
            }
        }
        
        var aimation: Animation {
            switch self {
            case .idle:
                return Animation.easeIn(duration: duration / 10)
            case .pending:
                return Animation.smooth(duration: duration / 10)
            case .animating:
                return Animation.easeOut(duration: duration * 8 / 10).repeatCount(4).speed(4)
            }
        }
    }
    
    let trigger: Bool
    @State var animationStatus: AnimationStatus = .idle
    
    func body(content: Content) -> some View {
        VStack {
            content
                .offset(x: animationStatus.offsetX)
                .animation(
                    animationStatus.aimation,
                    value: animationStatus
                )
                .onChange(of: trigger) { newValue in
                    animationStatus = .pending
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration / 10) {
                        animationStatus = .animating
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration * 8 / 10) {
                        animationStatus = .idle
                    }
                }
        }
    }
    
}
