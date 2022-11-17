//
//  View+Navigate.swift
//  
//
//  Created by Johnnie Cheng on 17/11/22.
//

import SwiftUI

public extension View {
    
    /// Navigate to a new view.
    /// - Parameters:
    ///   - destination: View to navigate to.
    ///   - isActive: Only navigates when this condition is `true`.
    func navigate<Destination: View>(
        to destination: Destination,
        when isActive: Binding<Bool>
    ) -> some View {
        modifier(NavigationModifier(destination: destination, isActive: isActive))
    }
    
}

fileprivate struct NavigationModifier<Destination: View>: ViewModifier {

    fileprivate var destination: Destination
    @Binding fileprivate var isActive: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            NavigationLink(
                destination: destination,
                isActive: $isActive
            ) {
                EmptyView()
            }
            .navigationViewStyle(.stack)
        }
    }

}
