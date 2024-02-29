// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation

struct ViewTransitionItem: Identifiable, Equatable {
    
    let id = UUID()
    let imageUrl: URL
    let title: String
    
    static func == (lhs: ViewTransitionItem, rhs: ViewTransitionItem) -> Bool {
        return lhs.id == rhs.id
    }

}
