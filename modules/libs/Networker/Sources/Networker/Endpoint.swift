// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation

open class Endpoint<Response: Decodable> {
    
    let path: String
    let method: NetworkMethod
    let body: [String: Any]?
    let additionalHeaders: NetworkHeaders
    let decoder: JSONDecoder
    
    public init(
        path: String,
        method: NetworkMethod = .get,
        queries: [String: Any]? = nil,
        body: [String: Any]? = nil,
        additionalHeaders: NetworkHeaders = [:],
        decoder: JSONDecoder = JSONDecoder()
    ) {
        if let queries, !queries.isEmpty {
            let queriesString = queries
                .map { "\($0)=\($1)" }
                .joined(separator: "&")
            self.path = "\(path)?\(queriesString)"
        } else {
            self.path = path
        }
        
        self.method = method
        self.body = body
        self.additionalHeaders = additionalHeaders
        self.decoder = decoder
    }
    
}
