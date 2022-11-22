//
//  NetworkerError.swift
//  
//
//  Created by Johnnie Cheng on 18/11/22.
//

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
