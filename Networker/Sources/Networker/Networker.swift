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
        for endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?,
        decodeAs: Response.Type
    ) -> Future<Response?, Error>
    
    func performRequest<Response: Decodable>(
        for endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?,
        decodeAs: Response.Type
    ) async throws -> Response

}


public class Networker: NetworkerProtocol {

    private let session: Session
    private let host: String

    init(
        host: String,
        configuration: URLSessionConfiguration = .default
    ) {
        self.host = host
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        session = Session(configuration: configuration)
    }

    public func performRequest<Response: Decodable>(
        for endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?,
        decodeAs: Response.Type
    ) -> Future<Response?, Error> {
        return session
            .request("\(host)\(endpoint)",
                     method: method,
                     parameters: parameters,
                     headers: headers)
            .validate()
            .publishDecodable()
            .asFuture()
    }
    
    public func performRequest<Response: Decodable>(
        for endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?,
        decodeAs: Response.Type
    ) async throws -> Response {
        let response = await session
           .request("\(host)\(endpoint)",
                    method: method,
                    parameters: parameters,
                    headers: headers)
           .validate()
           .serializingDecodable(Response.self)
           .response
           
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }

}

public extension NetworkerProtocol {

    /// heck extension to allow using protocol func with default parameter value
    /// this extension will call the actual [performRequest] func in implementation class
    func performRequest<Response: Decodable>(
        for endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        decodeAs: Response.Type = Response.self
    ) -> Future<Response?, Error> {
        performRequest(
            for: endpoint,
            method: method,
            parameters: parameters,
            headers: headers,
            decodeAs: decodeAs
        )
    }
    
    func performRequest<Response: Decodable>(
        for endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?,
        decodeAs: Response.Type
    ) async throws -> Response {
        return try await performRequest(
            for: endpoint,
            method: method,
            parameters: parameters,
            headers: headers,
            decodeAs: decodeAs
        )
    }

}

extension Networker {

    public static func registerInstance(
        host: String,
        in container: DIContainer
    ) {
        container.register(NetworkerProtocol.self) { resolver in
            return Networker(host: host)
        }
    }

}
