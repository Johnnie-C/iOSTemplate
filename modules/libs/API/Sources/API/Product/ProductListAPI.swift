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
        networker: NetworkerProtocol = Networker.productNetworker
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

public extension Networker {
    
    static var productNetworker: Networker {
        Networker(host: "https://61136f5ccba40600170c1a3f.mockapi.io/api/v1/")
    }
    
}
