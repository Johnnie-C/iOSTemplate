//
//  AttributedTextView.swift
//  
//
//  Created by Johnnie Cheng on 24/10/22.
//

import SwiftUI
import UIKit

public typealias TooltipTappedAction = (String) -> Void
public typealias LinkTappedAction = (_ label: String, _ url: URL) -> Bool

public struct AttributedTextView: View {
    
    @State var height: CGFloat = 0
    private let attributedText: NSAttributedString
    private let tooltipIcon: TooltipIcon
    private let tooltipTappedAction: TooltipTappedAction?
    private let linkTappedAction: LinkTappedAction?
    private let tooltipTagsParser: TooltipTagsParser
    
    public init(
        attributedText: NSAttributedString,
        tooltipIcon: TooltipIcon = .default,
        tooltipTappedAction: TooltipTappedAction? = nil,
        linkTappedAction: LinkTappedAction? = nil,
        tooltipTagsParser: TooltipTagsParser = DefaultTooltipTagsParser()
    ) {
        self.attributedText = attributedText
        self.tooltipIcon = tooltipIcon
        self.tooltipTappedAction = tooltipTappedAction
        self.linkTappedAction = linkTappedAction
        self.tooltipTagsParser = tooltipTagsParser
    }
    
    public var body: some View {
        AttributedTextViewRepresentable(
            attributedText: attributedText,
            tooltipIcon: tooltipIcon,
            tooltipTappedAction: tooltipTappedAction,
            linkTappedAction: linkTappedAction,
            tooltipTagsParser: tooltipTagsParser,
            height: $height
        )
            .frame(height: height)
    }
}

private struct AttributedTextViewRepresentable: UIViewRepresentable {
    
    let attributedText: NSAttributedString
    let tooltipIcon: TooltipIcon
    let tooltipTappedAction: TooltipTappedAction?
    let linkTappedAction: LinkTappedAction?
    let tooltipTagsParser: TooltipTagsParser
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.alwaysBounceVertical = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.backgroundColor  = .clear
        textView.linkTextAttributes = [
            .underlineStyle:NSUnderlineStyle.single.rawValue
        ]
        textView.layoutManager.delegate = context.coordinator
        context.coordinator.textView = textView
        context.coordinator.tooltipTappedAction = tooltipTappedAction
        context.coordinator.linkTappedAction = linkTappedAction
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let index = attributedText.string.index(of: "{?:") ?? 0
        let attributes = attributedText.attributes(at: index, effectiveRange: nil)
        let font = (attributes[.font] as? UIFont) ?? uiView.font
        let parseResult = context.coordinator.parseTooltipResult(
            forAttributedString: attributedText,
            tooltipIcon: tooltipIcon,
            font: font
        )
        
        uiView.attributedText = parseResult.message
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            attributedTextViewRepresentable: self,
            tooltipTagsParser: tooltipTagsParser
        )
    }
    
    class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {
        
        var attributedTextViewRepresentable: AttributedTextViewRepresentable
        var tooltips = [NSRange: String]()
        var tooltipTappedAction: TooltipTappedAction?
        var linkTappedAction: LinkTappedAction?
        var tooltipTagsParser: TooltipTagsParser
        
        weak var textView: UITextView? {
            didSet { textView? .delegate = self }
        }
    
        init(
            attributedTextViewRepresentable: AttributedTextViewRepresentable,
            tooltipTagsParser: TooltipTagsParser
        ) {
            self.attributedTextViewRepresentable = attributedTextViewRepresentable
            self.tooltipTagsParser = tooltipTagsParser
        }
        
        func parseTooltipResult(
            forAttributedString attributedString: NSAttributedString,
            tooltipIcon: TooltipIcon,
            font: UIFont?
        ) -> TooltipHandlerResult {
            let result = tooltipTagsParser.parseTooltipTags(
                attributedString: attributedString,
                tooltipIcon: tooltipIcon,
                font: font
            )
            tooltips = result.data
            return result
        }
        
        // MARK: - UITextViewDelegate
        func textView(
            _ textView: UITextView,
            shouldInteractWithtextAttachment:NSTextAttachment,
            in characterRange: NSRange,
            interaction: UITextItemInteraction
        ) -> Bool {
            guard
                let tooltipTappedAction = tooltipTappedAction,
                let message = tooltips[characterRange]
            else { return false }
            
            tooltipTappedAction(message)
            return false
        }
        
        func textView(
            _ textView: UITextView,
            shouldInteractWith URL: URL,
            in characterRange: NSRange,
            interaction: UITextItemInteraction
        ) -> Bool {
            guard let linkTappedAction = linkTappedAction else { return true }
            guard let text = textView.text else { return true }
            
            let startIndex = text.index(
                text.startIndex,
                offsetBy: characterRange.location
            )
            let endIndex = text.index(
                text.startIndex,
                offsetBy: characterRange.location + characterRange.length
            )
            let label = String(text[startIndex..<endIndex])
            
            return linkTappedAction(label, URL)
        }
            
        // MARK: - NSLayoutManagerDelegate
        func layoutManager(
            _ layoutManager: NSLayoutManager,
            didCompleteLayoutFor textContainer: NSTextContainer?,
            atEnd layoutFinishedFlag: Bool
        ) {
            DispatchQueue.main.async { [weak self] in
                guard let view = self?.textView else { return }
                
                let size = view.sizeThatFits(view.bounds.size)
                if self?.attributedTextViewRepresentable.height != size.height {
                    self?.attributedTextViewRepresentable.height = size.height + 1 // +1 to disable scroll
                }
            }
        }
    
    }
    
}

public struct TooltipIcon {
    
    public let icon: UIImage?
    public let padding: CGFloat
    
    public static var `default`: TooltipIcon {
        .init(icon: Icons.info.image(.infoBlue), padding: 0.0)
    }
    
}
