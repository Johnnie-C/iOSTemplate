//
//  ListView.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 23/10/21.
//

import SwiftUI
import Common

struct ListView<VM: ListViewModel>: View {
    
    @State var a: Bool = false

    let viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                AttributedTextView(
                    attributedText: NSAttributedString(string: "qwe {?:here is the message} qwe"),
                    tooltipTappedAction: { message in
                        
                    }
                )
            }
            .navigationTitle("Navigation")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .withErrorHandler(error: viewModel.$error)
            .withLoadingHandler(isLoading: viewModel.$isLoading)
        }
    }

}
