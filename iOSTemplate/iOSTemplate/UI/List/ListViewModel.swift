//
//  ListViewModel.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 17/10/21.
//

import UIKit
import Common

protocol ListViewModelProtocol: BaseViewModelProtocol {

    var items: Published<[ListEntity]?>.Publisher { get }
    func getList()
    
}

class ListViewModel: BaseViewModel, ListViewModelProtocol {

    private let interactor: ListInteractorProtocol
    @Published var _items: [ListEntity]?
    public var items: Published<[ListEntity]?>.Publisher { $_items }

    init(interactor: ListInteractorProtocol) {
        self.interactor = interactor
    }

    func getList() {
        _isLoading = true
        interactor.getList()
            .sink { completion in
                self._isLoading = false
                if case .failure(let error) = completion {
                    self._error = error
                }
            } receiveValue: { items in
                self._isLoading = false
                self._items = items
            }
            .store(in: &subscriptions)
    }

}

extension ListViewModel: DependencyRegistrarProtocol {

    static func registerInstance(in container: DIContainer) {
        container.register(ListViewModelProtocol.self) { resolver in
            let interactor = resolver.resolve(ListInteractorProtocol.self)!

            return ListViewModel(interactor: interactor)
        }
    }

}
