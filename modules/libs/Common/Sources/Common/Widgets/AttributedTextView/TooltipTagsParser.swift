// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public protocol TooltipTagsParser {
    
    func parseTooltipTags(
        attributedString: NSAttributedString,
        tooltipIcon: TooltipIcon,
        font: UIFont?
    ) -> TooltipHandlerResult
    
}

/// text between {?:  } will be displayed as info icon
public class DefaultTooltipTagsParser: TooltipTagsParser {
    
    public init() { }
    
    public func parseTooltipTags(
        attributedString: NSAttributedString,
        tooltipIcon: TooltipIcon,
        font: UIFont?
    ) -> TooltipHandlerResult {
        let result = TooltipHandlerResult()
        
        let str = attributedString.string
        let attrStr = NSMutableAttributedString(attributedString: attributedString)
        let textAttachment = NSTextAttachment.centered(
            with: tooltipIcon.icon,
            iconPadding: tooltipIcon.padding,
            font: font
        )
        let imageString = NSAttributedString(attachment: textAttachment)
        
        if let regex = try? NSRegularExpression(
            pattern: "\\{\\?:([^\\}]+)\\}",
            options: []
        ) {
            var reversedMessages: [String] = []
            // Need to reverse the matchs, bacause if replace the first range then the next will be different position
            let matches = regex.matches(
                in: str,
                range: NSRange(
                    str.startIndex...,
                    in: str
                )
            ).reversed()
            
            for match in matches {
                guard let messageRange = Range(match.range(at: 1), in: str) else { return result }
                let message = "\(str[messageRange])"
                reversedMessages.append (message)
                attrStr.replaceCharacters(in: match.range(at: 0), with: imageString)
            }
            
            // find ranges of replaced image strings
            var ranges: [NSRange] = []
            attrStr.enumerateAttribute(
                .attachment,
                in: NSRange(
                    location: 0,
                    length: attrStr.length
                )
            ) { value, range, _ in
                if value != nil {
                    ranges.append(range)
                }
            }
            
            // Set the ranges and messages to property
            for (range, message) in zip(ranges, reversedMessages.reversed()) {
                result.data[range] = message
            }
            result.message = attrStr
        }
        
        return result
    }
    
}

public class TooltipHandlerResult {
    
    public fileprivate(set) var message = NSAttributedString(string: "")
    public fileprivate(set) var data: [NSRange: String] = [:]
    
    func message(forRange range: NSRange) -> String? {
        self.data[range]
    }
    
}
