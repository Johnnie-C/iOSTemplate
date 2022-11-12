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

protocol ListViewModelProtocol: BaseViewModelProtocol {

}

class ListViewModel: BaseViewModel, ListViewModelProtocol {
    
    override init() {
        super.init()
        
        // test
        Task {
            do {
                try await DefaultProductsProvider().productList()
            }
            catch {
                print(error)
            }
        }
        
    }

}
