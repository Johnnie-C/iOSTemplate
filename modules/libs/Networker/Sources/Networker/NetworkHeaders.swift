// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Alamofire

public typealias NetworkHeaders = [String: String]

extension NetworkHeaders {
    
    var httpHeaders: HTTPHeaders {
        return .init(self)
    }
    
}
