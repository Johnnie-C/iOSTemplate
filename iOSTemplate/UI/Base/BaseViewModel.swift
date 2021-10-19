//
//  BasePresenter.swift
//  MegaBudget
//
//  Created by Johnnie Cheng on 29/4/21.
//

import Foundation
import Combine

public protocol BaseViewModelProtocol {

    var isLoading: Published<Bool>.Publisher { get }
    var error: Published<Error?>.Publisher { get }

}

open class BaseViewModel: BaseViewModelProtocol {

    @Published var _isLoading: Bool = false
    public var isLoading: Published<Bool>.Publisher { $_isLoading }

    @Published var _error: Error? = nil
    public var error: Published<Error?>.Publisher { $_error }

    var subscriptions = Set<AnyCancellable>()

}
