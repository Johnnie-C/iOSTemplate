//
//  ListInteractor.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 19/10/21.
//

import Foundation
import Combine
import Common
import Combine
import Networker

protocol ListInteractorProtocol {

    func getList() -> AnyPublisher<[ListEntity]?, Error>
    
}

class ListInteractor: ListInteractorProtocol {

    private let networker: NetworkerProtocol

    init(networker: NetworkerProtocol) {
        self.networker = networker
    }

    func getList() -> AnyPublisher<[ListEntity]?, Error> {
        return networker.performRequest(for: "product",
                                    method: .get,
                                    decodeAs: ListResponse.self)
            .map {
                $0?.products
            }
            .eraseToAnyPublisher()
    }

}

extension ListInteractor: DependencyRegistrarProtocol {

    static func registerInstance(in container: DIContainer) {
        container.register(ListInteractorProtocol.self) { resolver in
            let networker = resolver.resolve(NetworkerProtocol.self)!

            return ListInteractor(networker: networker)
        }
    }

}
