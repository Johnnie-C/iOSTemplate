//
//  DIConfig.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 19/10/21.
//

import Common
import Networker

extension DIContainer {

    func config() {
        register(String.self, name: NetworkHostDIKey) { _ in
            return "https://61136f5ccba40600170c1a3f.mockapi.io/api/v1/"
        }
        Networker.registerInstance(in: self)

        ListBuilder.registerInstance(in: self)
        ListInteractor.registerInstance(in: self)
        ListViewModel.registerInstance(in: self)
    }

}
