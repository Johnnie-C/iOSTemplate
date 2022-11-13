//
//  ListViewModel.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 30/10/21.
//

import Foundation
import Combine
import Common
import UIKit
import Product

protocol ListViewModelProtocol: ObservableObject {
    
    var isLoading: Bool { get set }
    var alertMessage: AlertMessage? { get set }
    func onAppear()

}

class ListViewModel: ListViewModelProtocol {
    
    @Published var isLoading = false
    @Published var alertMessage: AlertMessage? = nil
    
    init() {
        
    }
    
    func onAppear() {
        Task {
            do {
                await setLoading(true)
                try await DefaultProductsProvider().productList()
                await setLoading(false)
                await setAlertMessage(.init(
                    title: "alert.generalError.title".localized,
                    message: "alert.generalError.message".localized,
                    alertMode: .hud,
                    alertStyle: .error(.red)
                ))
            }
            catch {
                print(error)
                await setLoading(false)
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
