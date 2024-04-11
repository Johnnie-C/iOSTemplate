// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Networker
import Common

public protocol ProductAPI {
    func productList() async throws -> ProductListDTO
}

public class DefaultProductAPI: ProductAPI {
    
    private let networker: NetworkerProtocol
    
    public init(
        networker: NetworkerProtocol = Networker.productNetworker
    ) {
        self.networker = networker
    }
    
    public func productList() async throws -> ProductListDTO {
        try await networker.performRequest(ProductListEndpoint())
    }

}

public extension Networker {
    
    static var productNetworker: Networker {
        Networker(host: "https://61136f5ccba40600170c1a3f.mockapi.io/api/v1/")
    }
    
}
