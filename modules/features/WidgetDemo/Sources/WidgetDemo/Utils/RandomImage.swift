//
//  RandomImage.swift
//  
//
//  Created by Xiaojun Cheng on 31/05/23.
//

import Foundation

class RandomImage {
    
    enum Size {
        case small
        case medium
        case large
        
        var width: Double {
            let defaultWidth = 500.0
            switch self {
            case .small: return defaultWidth * 0.3
            case .medium: return defaultWidth
            case .large: return defaultWidth * 1.5
            }
        }
        
        var height: Double {
            let defaultHeight = 300.0
            switch self {
            case .small: return defaultHeight * 0.3
            case .medium: return defaultHeight
            case .large: return defaultHeight * 1.5
            }
        }
    }
    
    func url(
        id: Int? = nil,
        width: Double,
        height: Double
    ) -> URL {
        let idString = id == nil ? "" : "id/\(id!)/"
        
        return URL(string: "https://picsum.photos/\(idString)\(Int(width))/\(Int(height))")!
    }
    
    func url(
        id: Int? = nil,
        size: Size = .medium
    ) -> URL {
        url(
            id: id,
            width: size.width,
            height: size.height
        )
    }
    
}
