//
//  ListView.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 23/10/21.
//

import SwiftUI

struct ListView<VM: ListViewModel>: View {

    let viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
            }
            .navigationTitle("Navigation")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .withErrorHandler(error: viewModel.$error)
            .withLoadingHandler(isLoading: viewModel.$isLoading)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}
