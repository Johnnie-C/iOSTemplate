//
//  ProductListViewModel.swift
//  
//
//  Created by Johnnie Cheng on 13/11/22.
//

import Foundation
import Common

public protocol ProductListViewModel: ObservableObject {
    
    var isLoading: Bool { get set }
    var alertMessage: AlertMessage? { get set }
    var productList: ProductList? { get }
    func onAppear()

}

public class DefaultProductListViewModel: ProductListViewModel {
    
    @Published public var isLoading = false
    @Published public var alertMessage: AlertMessage? = nil
    @Published public var productList: ProductList?
    
    private let productProvider: ProductsProvider
    
    public init(
        productProvider: ProductsProvider = DefaultProductsProvider()
    ) {
        self.productProvider = productProvider
    }
    
    public func onAppear() {
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
            }
            catch {
                print(error)
                await setLoading(false)
                await setAlertMessage(.init(
                    title: "Alert.generalError.Title".localized,
                    message: "Alert.generalError.Message".localized,
                    alertMode: .hud,
                    alertStyle: .error(.red)
                ))

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

}
