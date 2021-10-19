//
//  DIConfig.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 19/10/21.
//

import UIKit

extension DIContainer {

    func config() {
        Network.registerInstance(in: self)

        ListAssembly.registerInstance(in: self)
        ListInteractor.registerInstance(in: self)
        ListViewModel.registerInstance(in: self)
    }

}
