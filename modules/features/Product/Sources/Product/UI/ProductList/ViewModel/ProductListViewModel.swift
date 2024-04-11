// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Common

public class ProductListViewModel: ObservableObject {
    
    @Published public var isLoading = false
    @Published public var alertMessage: AlertMessage? = nil
    @Published public var productList: ProductList?
    @Published public var error: Error?
    
    private let productProvider: ProductsProvider
    
    public init(
        productProvider: ProductsProvider = DefaultProductsProvider()
    ) {
        self.productProvider = productProvider
    }
    
    public func onAppear() {
        loadProductsInNeeded()
    }
    
    public func reload() {
        productList = nil
        loadProductsInNeeded()
    }
    
    private func loadProductsInNeeded() {
        if productList?.products?.isEmpty == false { return }
        
        Task {
            do {
                await setLoading(true)
                let productList = try await productProvider.productList()
                await didLoadProductList(productList)
                await setLoading(false)
                await setError(nil)
            }
            catch {
                await setLoading(false)
                
                if productList == nil {
                    await setError(error)
                } else {
                    await setAlertMessage(
                        AlertMessage(
                            title: .genericErrorTitle,
                            message: .genericErrorMessage,
                            alertStyle: .error(.red)
                        )
                    )
                }
            }
        }
    }
    
    @MainActor
    private func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    @MainActor
    private func setAlertMessage(_ alertMessage: AlertMessage) {
        self.alertMessage = alertMessage
    }
    
    @MainActor
    private func didLoadProductList(_ productList: ProductList) {
        self.productList = productList
    }
    
    @MainActor
    private func setError(_ error: Error?) {
        self.error = error
    }

}

enum TestError: Error {
    case test
}
