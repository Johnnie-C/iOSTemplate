//
//  NetworkHeaders.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Alamofire

public typealias NetworkHeaders = [String: String]

extension NetworkHeaders {
    
    var httpHeaders: HTTPHeaders {
        return .init(self)
    }
    
}
