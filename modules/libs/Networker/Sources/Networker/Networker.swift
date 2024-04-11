// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Alamofire
import Combine
import Common

public protocol NetworkerProtocol {
    
    func performRequest<Response: Decodable>(
        _ endpoint: Endpoint<Response>
    ) -> AnyPublisher<Response, Error>
    
    func performRequest<Response: Decodable>(
        _ endpoint: Endpoint<Response>
    ) async throws -> Response
    
}

public class Networker: NetworkerProtocol {
    
    private let session: Session
    private let host: String
    public var globalHeaders: NetworkHeaders
    
    public init(
        host: String,
        globalHeaders: NetworkHeaders = [:],
        configuration: URLSessionConfiguration = .default,
        cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData,
        urlCache: URLCache? = nil
    ) {
        self.host = host
        self.globalHeaders = globalHeaders
        configuration.requestCachePolicy = cachePolicy
        configuration.urlCache = urlCache
        session = Session(configuration: configuration)
    }
    
    public func performRequest<Response: Decodable>(
        _ endpoint: Endpoint<Response>
    ) -> AnyPublisher<Response, Error> {
        return session
            .request(
                "\(host)\(endpoint.path)",
                method: endpoint.method.httpMethod,
                parameters: endpoint.body,
                headers: allHeaders(with: endpoint.additionalHeaders)
            )
            .validate()
            .publishDecodable(type: Response.self, decoder: endpoint.decoder)
            .value()
            .mapError{ NetworkerError(afError: $0) }
            .eraseToAnyPublisher()
    }
    
    public func performRequest<Response: Decodable>(
        _ endpoint: Endpoint<Response>
    ) async throws -> Response {
        let response = await session
            .request(
                "\(host)\(endpoint.path)",
                method: endpoint.method.httpMethod,
                parameters: endpoint.body,
                headers: allHeaders(with: endpoint.additionalHeaders)
            )
            .validate()
            .serializingDecodable(Response.self, decoder: endpoint.decoder)
            .response
        
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw NetworkerError(afError: error)
        }
    }
    
    private func allHeaders(with extraHeaders: NetworkHeaders) -> HTTPHeaders? {
        let allHeaders = globalHeaders.merging(extraHeaders) { $1 }
        
        guard !allHeaders.isEmpty else { return nil }
        
        return allHeaders.httpHeaders
    }
    
}

public extension Networker {
    
    static func registerInstance(
        host: String,
        name: String? = nil,
        in container: DIContainer
    ) {
        container.register(NetworkerProtocol.self, name: name) { resolver in
            return Networker(host: host)
        }
    }
    
    static func registerInstance(
        networker: Networker,
        name: String? = nil,
        in container: DIContainer
    ) {
        container.register(NetworkerProtocol.self, name: name) { resolver in
            return networker
        }
    }
    
}
