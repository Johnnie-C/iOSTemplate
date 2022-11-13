//
//  Networker.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 17/10/21.
//

import Foundation
import Alamofire
import Combine
import Common

public enum NetworkError: Error {
    
    case invalidURL
    
}

public protocol NetworkerProtocol {
    
    func performRequest<Response: Decodable>(
        forEndpoint endpoint: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        headers: NetworkHeaders,
        decoder: JSONDecoder,
        decodeAs: Response.Type
    ) -> Future<Response?, Error>
    
    func performRequest<Response: Decodable>(
        forEndpoint endpoint: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        headers: NetworkHeaders,
        decoder: JSONDecoder,
        decodeAs: Response.Type
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
        cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    ) {
        self.host = host
        self.globalHeaders = globalHeaders
        configuration.requestCachePolicy = cachePolicy
        session = Session(configuration: configuration)
    }
    
    public func performRequest<Response: Decodable>(
        forEndpoint endpoint: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        headers: NetworkHeaders,
        decoder: JSONDecoder = JSONDecoder(),
        decodeAs: Response.Type
    ) -> Future<Response?, Error> {
        return session
            .request(
                "\(host)\(endpoint)",
                method: method.httpMethod,
                parameters: parameters,
                headers: allHeaders(with: headers)
            )
            .validate()
            .publishDecodable(decoder: decoder)
            .asFuture()
    }
    
    public func performRequest<Response: Decodable>(
        forEndpoint endpoint: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        headers: NetworkHeaders,
        decoder: JSONDecoder = JSONDecoder(),
        decodeAs: Response.Type
    ) async throws -> Response {
        let response = await session
            .request(
                "\(host)\(endpoint)",
                method: method.httpMethod,
                parameters: parameters,
                headers: allHeaders(with: headers)
            )
            .validate()
            .serializingDecodable(Response.self, decoder: decoder)
            .response
        
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    private func allHeaders(with extraHeaders: NetworkHeaders) -> HTTPHeaders? {
        let allHeaders = globalHeaders.merging(extraHeaders) { $1 }
        
        guard !allHeaders.isEmpty else { return nil }
        
        return allHeaders.httpHeaders
    }
    
}

public extension NetworkerProtocol {
    
    /// heck extension to allow using protocol func with default parameter value
    /// this extension will call the actual [performRequest] func in implementation class
    func performRequest<Response: Decodable>(
        forEndpoint endpoint: String,
        method: NetworkMethod = .get,
        parameters: [String: Any]? = nil,
        headers: NetworkHeaders = [:],
        decoder: JSONDecoder = JSONDecoder(),
        decodeAs: Response.Type = Response.self
    ) -> Future<Response?, Error> {
        performRequest(
            forEndpoint: endpoint,
            method: method,
            parameters: parameters,
            headers: headers,
            decoder: decoder,
            decodeAs: decodeAs
        )
    }
    
    func performRequest<Response: Decodable>(
        forEndpoint endpoint: String,
        method: NetworkMethod = .get,
        parameters: [String: Any]? = nil,
        headers: NetworkHeaders = [:],
        decoder: JSONDecoder = JSONDecoder(),
        decodeAs: Response.Type = Response.self
    ) async throws -> Response {
        return try await performRequest(
            forEndpoint: endpoint,
            method: method,
            parameters: parameters,
            headers: headers,
            decoder: decoder,
            decodeAs: decodeAs
        )
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
