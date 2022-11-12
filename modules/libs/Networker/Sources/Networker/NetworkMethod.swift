//
//  NetworkMethod.swift
//  
//
//  Created by Johnnie Cheng on 12/11/22.
//

import Alamofire

public enum NetworkMethod {
    
    /// `CONNECT` method.
    case connect
    /// `DELETE` method.
    case delete
    /// `GET` method.
    case get
    /// `HEAD` method.
    case head
    /// `OPTIONS` method.
    case options
    /// `PATCH` method.
    case patch
    /// `POST` method.
    case post
    /// `PUT` method.
    case put
    /// `QUERY` method.
    case query
    /// `TRACE` method.
    case trace

}

extension NetworkMethod {
    
    var httpMethod: HTTPMethod {
        switch self {
        case .connect:
            return .connect
        case .delete:
            return .delete
        case .get:
            return .get
        case .head:
            return .head
        case .options:
            return .options
        case .patch:
            return .patch
        case .post:
            return .post
        case .put:
            return .put
        case .query:
            return .query
        case .trace:
            return .trace
        }
    }
    
}
