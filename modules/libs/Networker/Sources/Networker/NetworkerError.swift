// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Alamofire

public enum NetworkerError: Error {

    case general(httpCode: Int, message: String?)
    case unknown
    
    init(afError: AFError) {
        self = NetworkerError.general(
            httpCode: afError.responseCode ?? -999,
            message: afError.errorDescription
        )
    }
    
}
