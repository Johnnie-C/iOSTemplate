//
//  ProductListViewModel.swift
//  
//
//  Created by Johnnie Cheng on 13/11/22.
//

import Foundation
import Common

protocol ProductListViewModelProtocol: ObservableObject {
    
    var isLoading: Bool { get set }
    var alertMessage: AlertMessage? { get set }
    func onAppear()

}

class ProductListViewModel: ProductListViewModelProtocol {
    
    @Published var isLoading = false
    @Published var alertMessage: AlertMessage? = nil
    @Published var productList: ProductList?
    
    private let productProvider: ProductsProvider
    
    init(productProvider: ProductsProvider = DefaultProductsProvider()) {
        self.productProvider = productProvider
    }
    
    func onAppear() {
        Task {
            do {
                await setLoading(true)
                productList = try await productProvider.productList()
                await setLoading(false)
            }
            catch {
                print(error)
                await setLoading(false)
                await setAlertMessage(.init(
                    title: "alert.generalError.title".localized,
                    message: "alert.generalError.message".localized,
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

}
