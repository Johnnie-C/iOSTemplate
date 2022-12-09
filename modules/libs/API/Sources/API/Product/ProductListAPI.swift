// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Networker
import Common
import Alamofire

public protocol ProductListAPI {
    func productList() async throws -> ProductListDTO
}

public class DefaultProductListAPI: ProductListAPI {
    
    enum EndPoint: String {
        case productList = "product"
    }
    
    private let networker: NetworkerProtocol
    
    public init(
        networker: NetworkerProtocol = DIContainer.default.resolve(type: NetworkerProtocol.self)
    ) {
        self.networker = networker
    }
    
    public func productList() async throws -> ProductListDTO {
        try await networker.performRequest(
            forEndpoint: EndPoint.productList.rawValue,
            decoder: .dateFormattedDecoder(.fullWithSSS)
        )
    }

}
