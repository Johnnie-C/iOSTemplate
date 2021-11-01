//
//  BaseViewModel.swift
//  iOSTemplateSwiftUI
//
//  Created by Johnnie Cheng on 30/10/21.
//

import Foundation
import SwiftUI

protocol BaseViewModelProtocol: ObservableObject {

    var isLoading: Bool { get }
    var error: Error? { get }

}

class BaseViewModel: BaseViewModelProtocol {

    @Published var isLoading = false
    @Published var error: Error? = nil

}
