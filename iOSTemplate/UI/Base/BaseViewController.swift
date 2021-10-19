//
//  BaseViewController.swift
//  MegaBudget
//
//  Created by Johnnie Cheng on 29/4/21.
//

import UIKit
import Combine
import Loaf
import NVActivityIndicatorView


open class BaseViewController<ViewModel: BaseViewModelProtocol>: UIViewController, Identifiable {

    var viewModel: ViewModel!
    var loadingView: NVActivityIndicatorView?
    var loader: UIView!
    var subscriptions = Set<AnyCancellable>()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
        startObservingLoadingStatus()
        startObservingError()
    }

    private func setupLoadingView() {
        loadingView = NVActivityIndicatorView(frame: CGRect.zero,
                                              type: .ballPulseSync,
                                              color: .primaryColor,
                                              padding: 0)
        loadingView?.clipsToBounds = true
        loadingView?.layer.cornerRadius = 5
        loadingView?.padding = 20
        loadingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadingView?.center(inSuperView: view, width: 75, height: 75, verticalAdjustmentConstant: -40)
    }

    private func startObservingLoadingStatus() {
        guard let viewModel = viewModel else { return }

        viewModel.isLoading.sink { isLoading in
            isLoading ? self.showLoader() : self.hideLoader()
        }
        .store(in: &subscriptions)
    }

    private func startObservingError() {
        guard let viewModel = viewModel else { return }

        viewModel.error.sink { error in
            guard let error = error else { return }

            self.handleError(error)
        }
        .store(in: &subscriptions)
    }

    open func showLoader() {
        guard let loadingView = loadingView else { return }

        view.bringSubviewToFront(loadingView)
        loadingView.startAnimating()
    }

    open func hideLoader() {
        self.loadingView?.stopAnimating()
    }

    open func handleError(_ error: Error) {
        Loaf(localizedString(withKey: "alert.generalError.message"),
             state: .error,
             location: .top,
             sender: self).show()
    }

}
