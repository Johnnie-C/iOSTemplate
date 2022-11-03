//
//  NSAttributedStringExtension.swift
//  
//
//  Created by Johnnie Cheng on 20/10/22.
//

import UIKit
import SwiftUI

public extension String {
    
    func attributed() -> NSAttributedString {
        .init(string: self)
    }
    
    func styled(
        font: UIFont,
        color: Color
    ) -> NSAttributedString {
        attributed().font(font).color(color)
    }
    
    func styled(
        font: UIFont,
        color: Colors = .primaryLabel
    ) -> NSAttributedString {
        styled(font: font, color: color.dynamicColor())
    }
    
}

public extension NSAttributedString {
    
    func mutable() -> NSMutableAttributedString {
        return self.mutableCopy() as! NSMutableAttributedString
    }
    
    func font(_ font: UIFont) -> NSAttributedString {
        let attributedStr = mutable()
        
        attributedStr.addAttributes(
            [.font: font],
            range: NSRange(location: 0, length: attributedStr.length)
        )
        
        return attributedStr
    }
    
    func color(_ color: Color) -> NSAttributedString {
        self.color(UIColor(color))
    }
    
    func color(_ color: UIColor) -> NSAttributedString {
        let attributedStr = mutable()
        
        attributedStr.addAttributes(
            [.foregroundColor: color],
            range: NSRange(location: 0, length: attributedStr.length)
        )
        
        return attributedStr
    }
    
    func frameSize(
        maxWidth: CGFloat?
        = nil,
        maxHeight: CGFloat? = nil
    ) -> CGSize {
        let width = maxWidth != nil
        ? min(maxWidth!, CGFloat.greatestFiniteMagnitude)
        : CGFloat.greatestFiniteMagnitude
        let height = maxHeight != nil
        ? min(maxHeight!, CGFloat.greatestFiniteMagnitude)
        : CGFloat.greatestFiniteMagnitude
        let constraintBox = CGSize(width: width, height: height)
        let rect = boundingRect(
            with: constraintBox,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        ).integral
        
        return rect.size
    }
    
    func alignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        let mutableString = self.mutable()
        
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        mutableString.addAttributes(
            [.paragraphStyle: style],
            range: NSRange(location: 0, length: mutableString.length)
        )
        
        return mutableString
    }
    
    func appendingIcon(
        _ icon: UIImage,
        forFont font: UIFont,
        withSpacing spacing: CGFloat
    ) -> NSAttributedString {
        let titleWithImage = NSMutableAttributedString(attributedString: self)
        let imageAttachment = NSTextAttachment()
        imageAttachment.bounds = CGRect (
            x: 0,
            y: ((font.capHeight) - icon.size.height).rounded() / 2,
            width: icon.size.width,
            height: icon.size.height
        )
        imageAttachment.image = icon
        let spacerAttachment = NSTextAttachment()
        spacerAttachment.bounds = CGRect(
            x: 0,
            y: 0,
            width: spacing,
            height: 0
        )
        titleWithImage.append(NSAttributedString(attachment: spacerAttachment))
        titleWithImage.append(NSAttributedString(attachment: imageAttachment))
        
        return titleWithImage
    }
    
    func link(_ url: String) -> NSAttributedString {
        guard self.length > 0 else { return self }
    
        let mutableString = self.mutable()
        mutableString.addAttribute(
            .link,
            value: url,
            range: NSRange(
                location: 0,
                length: mutableString.length
            )
        )
        
        return mutableString
    }
    
    func kern(_ kerning: Kerning) -> NSAttributedString {
        guard self.length > 0 else { return self }
    
        let mutableString = self.mutable()
        mutableString.addAttribute(
            .kern,
            value: kerning.rawValue,
            range: NSRange(
                location: 0, length: mutableString.length
            )
        )
        
        return mutableString
    }
    
    func lineSpacing(_ spacing: LineSpacing) -> NSAttributedString {
        guard self.length > 0 else { return self }
                    
        let mutableString = self.mutable()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing.rawValue
        mutableString.addAttribute(
            .paragraphStyle,
            value:paragraphStyle,
            range: NSRange(location: 0, length: mutableString.length)
        )
        
        return mutableString
    }

}
