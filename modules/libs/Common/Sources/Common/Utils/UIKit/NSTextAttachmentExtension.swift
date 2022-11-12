//
//  NSTextAttachmentExtension.swift
//  
//
//  Created by Johnnie Cheng on 24/10/22.
//

import UIKit

public extension NSTextAttachment {
    
    static func centered(
        with icon: UIImage?,
        iconPadding: CGFloat,
        font: UIFont?
    ) -> NSTextAttachment {
        let imageAttachment = NSTextAttachment()
        if let font = font,
           let icon = icon {
            // the icon itself has padding around it
            // need to modify the size and position to make it visually sit on the text baseline
            let imageHeight = font.capHeight + iconPadding * 2 // top + bottom
            let imageRatio = icon.size.width / icon.size.height
            imageAttachment.bounds = CGRect(
                x: 0,
                y: -iconPadding,
                width: imageRatio * imageHeight,
                height: imageHeight
            )
            imageAttachment.image = icon
        }
        
        return imageAttachment
    }
    
}
