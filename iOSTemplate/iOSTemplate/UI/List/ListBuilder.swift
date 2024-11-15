// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import Common

protocol ListBuilderProtocol {

    func listViewController() -> ListViewController<ListViewModel>

}

class ListBuilder: ListBuilderProtocol {

    func listViewController() -> ListViewController<ListViewModel> {
        let interactor = DIContainer.default.resolve(type: ListInteractorProtocol.self)!
        let vm = ListViewModel(interactor: interactor)
        
        return ListViewController.newInstance(viewModel: vm)
    }

}

extension ListBuilder: DependencyRegistrarProtocol {

    static func registerInstance(in container: DIContainer) {
        container.register(ListBuilderProtocol.self) { resolver in
            return ListBuilder()
        }
    }

}

