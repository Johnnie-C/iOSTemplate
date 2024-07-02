// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Combine

@available(iOS 16.0, *)
struct BottomSheetView<Content: View, Sheet: View>: View {
    
    @Environment(\.windowSafeArea) var windowSafeArea
    
    // try use VM with ObservedObject, so we can update the estimatedHeight everytime for different sheet
    
    @Binding var isPresented: Bool
    @State var measuredHeight: CGFloat
    @State private var measuredHeightTask: Task<(), Never>?
    
    let content: () -> Content
    let sheet: () -> Sheet
    let onDismiss: (() -> Void)?
    let allowDismiss: Bool
    
    private let estimatedHeight: BottomSheetEstimatedHeight
    private let measuredHeightSubject = CurrentValueSubject<CGFloat, Never>(0)
    private let measuredHeightPublisher: AnyPublisher<CGFloat, Never>
    
    public init(
        isPresented: Binding<Bool>,
        estimatedHeight: BottomSheetEstimatedHeight = .small,
        allowDismiss: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder sheet: @escaping () -> Sheet
    ) {
        self._isPresented = isPresented
        self.estimatedHeight = estimatedHeight
        self.onDismiss = onDismiss
        self.allowDismiss = allowDismiss
        self.content = content
        self.sheet = sheet
//        self.measuredHeight = estimatedHeight.height
        self.measuredHeight = 0
        
        self.measuredHeightPublisher = measuredHeightSubject
//            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .filter { $0 < UIScreen.main.bounds.size.height * 0.85 }
//            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var body: some View {
        content()
            .sheet(isPresented: $isPresented) {
                onDismiss?()
                measuredHeight = 0
            } content: {
                VStack {
                    sheet()
                        .padding(.top, allowDismiss ? .medium : .zero)
                }
                .observeFrame(in: .global) { frame in
                    print("observed heigt: \(frame.height)")
                    measuredHeightSubject.send(frame.height)
                }
                .presentationDetents([.height(measuredHeight)])
//                .presentationDetents([.custom(TestDetent.self)])
//                .presentationDetents([.fraction(1)])
                .presentationDragIndicator(allowDismiss ? .visible : .hidden)
                .fixedSize(horizontal: false, vertical: true)
                .interactiveDismissDisabled(!allowDismiss)
            }
            .onReceive(measuredHeightPublisher) { height in
                print("received heigt: \(height)")
                if height <= 0 || height > UIScreen.main.bounds.size.height * 0.85 {
                    measuredHeight = UIScreen.main.bounds.size.height * 0.85
                } else {
                    measuredHeight = height
                }
                
                measuredHeightTask?.cancel()
                measuredHeightTask = Task {
                    do {
                        try await Task.sleep(nanoseconds: 100_000_000)
                        if !Task.isCancelled {
                            measuredHeight = measuredHeightSubject.value
                        }
                    } catch {
                        
                    }
                    
                }
//                measuredHeight = height
                
                
//                DispatchQueue.main.async {
//                    measuredHeight = height <= 0 ? UIScreen.main.bounds.size.height / 2 : height
//                }
            }
    }
    
}

class TestDetent: CustomPresentationDetent {
    
    @available(iOS 16.0, *)
    static func height(in context: Context) -> CGFloat? {
        print("context.maxDetentValue: \(context.maxDetentValue)")
        print("screenSize: \(UIScreen.main.bounds.size.height)")
        print("diff: \(UIScreen.main.bounds.size.height - context.maxDetentValue)")
        return UIScreen.main.bounds.size.height / 2
    }
    
}
