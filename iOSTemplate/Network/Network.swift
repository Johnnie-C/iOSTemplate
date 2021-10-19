//
//  Network.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 17/10/21.
//

import Foundation
import Alamofire
import Combine

enum NetworkError: Error {

    case invalidURL

}

protocol NetworkerProtocol {

    func performRequest<Response: Decodable>(for endpoint: String,
                                             method: HTTPMethod,
                                             parameters: [String: Any]?,
                                             headers: HTTPHeaders?,
                                             decodeAs: Response.Type)
        -> Future<Response?, Error>

}


class Network: NetworkerProtocol {

    private let session: Session
    private let host = "https://61136f5ccba40600170c1a3f.mockapi.io/api/v1/"

    init(configuration: URLSessionConfiguration = .default) {
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        session = Session(configuration: configuration)
    }

    func performRequest<Response: Decodable>(for endpoint: String,
                                             method: HTTPMethod,
                                             parameters: [String: Any]?,
                                             headers: HTTPHeaders?,
                                             decodeAs: Response.Type)
        -> Future<Response?, Error>
    {
        return session
            .request("\(host)\(endpoint)",
                     method: method,
                     parameters: parameters,
                     headers: headers)
            .validate()
            .publishDecodable()
            .asFuture()
    }

}

extension NetworkerProtocol {

    /// heck extension to allow using protocol func with default parameter value
    /// this extension will call the actual [performRequest] func in implementation class
    func performRequest<Response: Decodable>(for endpoint: String,
                                             method: HTTPMethod = .get,
                                             parameters: [String: Any]? = nil,
                                             headers: HTTPHeaders? = nil,
                                             decodeAs: Response.Type = Response.self)
        -> Future<Response?, Error>
    {
        return performRequest(for: endpoint,
                              method: method,
                              parameters: parameters,
                              headers: headers,
                              decodeAs: decodeAs)
    }

}

extension Network: DependencyRegistrarProtocol {

    static func registerInstance(in container: DIContainer) {
        container.register(NetworkerProtocol.self) { resolver in
            return Network()
        }
    }

}
