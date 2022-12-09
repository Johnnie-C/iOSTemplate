// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Common
import Networker

extension DIContainer {

    func config() {
        Networker.registerInstance(
            host: "https://61136f5ccba40600170c1a3f.mockapi.io/api/v1/",
            in: self
        )
//
//        ListBuilder.registerInstance(in: self)
//        ListInteractor.registerInstance(in: self)
//        ListViewModel.registerInstance(in: self)
    }

}
