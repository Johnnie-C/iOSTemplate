//
//  ListView.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 23/10/21.
//

import SwiftUI
import Common

struct ListView<VM: ListViewModelProtocol>: View {

    @ObservedObject var viewModel: VM

    init(viewModel: VM = ListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("test body").font(FontStyle.body().dynamicFont)
                Text("test bold italic").font(FontStyle.body(weight: .bold, italic: true).dynamicFont)
                Text("test title1 heavy").font(FontStyle.title1(weight: .heavy).dynamicFont)
                AttributedTextView(
                    attributedText: "qwe {?:here is the message} qwe".attributed(),
                    tooltipTappedAction: { message in
                        
                    }
                )
            }
            .navigationTitle("List")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alertMessage(alertMessage: $viewModel.alertMessage)
            .withLoadingHandler(isLoading: $viewModel.isLoading)
            .onAppear { viewModel.onAppear() }
        }
    }

}
