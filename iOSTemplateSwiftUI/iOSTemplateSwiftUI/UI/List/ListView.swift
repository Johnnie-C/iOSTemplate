//
//  ListView.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 23/10/21.
//

import SwiftUI
import Common

struct ListView<VM: ListViewModel>: View {

    let viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("test").font(FontStyle.body.dynamicFont)
                Text("test bold").font(Font(UIFont.preferredFont(forTextStyle: .title1)).bold())
                Text("test book bold")
//                    .font(FontStyle.title1.dynamicFont.bold())
                    .font(.custom("StagSans-Book", size: 40).italic())
                AttributedTextView(
                    attributedText: "qwe {?:here is the message} qwe".attributed(),
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
