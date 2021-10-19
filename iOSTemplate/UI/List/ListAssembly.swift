//
//  ListAssembly.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 17/10/21.
//

import UIKit

protocol ListAssemblyProtocol {

    func listViewController() -> ListViewController<ListViewModel>

}

class ListAssembly: ListAssemblyProtocol {

    func listViewController() -> ListViewController<ListViewModel> {
        let vm = DIContainer.default.resolve(type: ListViewModelProtocol.self)!
        
        return ListViewController.newInstance(viewModel: vm as! ListViewModel)
    }

}

extension ListAssembly: DependencyRegistrarProtocol {

    static func registerInstance(in container: DIContainer) {
        container.register(ListAssemblyProtocol.self) { resolver in
            return ListAssembly()
        }
    }

}

