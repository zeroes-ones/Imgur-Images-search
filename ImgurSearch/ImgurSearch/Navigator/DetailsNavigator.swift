//
//  DetailsNavigator.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

final class DetailsNavigator: Navigator {

    private weak var rootViewController: UIViewController?
    private let destination: Destination
    private let navigationType: NavigationType
    private(set) weak var navigationController: UINavigationController?

    init(
        root: Presentable?,
        destination: Destination,
        navigationType: NavigationType
    ) {
        self.rootViewController = root
        self.destination = destination
        self.navigationType = navigationType
    }

    func popToRootView() {
        rootViewController?.navigationController?.popToRootViewController(animated: true)
    }

    func navigate() {
        navigate(to: destination, type: navigationType)
    }
}

extension DetailsNavigator {
    enum Destination {
        case imgurList(ImgurViewModel)
        case detailView(ImgurModel.Data)
    }

    func navigate(
        to destination: Destination,
        type: NavigationType = .push
        ) {
        guard let viewController = makeViewController(for: destination) else {
            return
        }
        switch type {
        case .push:
            guard let navigationController = rootViewController?.navigationController else {
                self.navigationController = UINavigationController(rootViewController: viewController)
                rootViewController = viewController
                return
            }
            navigationController.pushViewController(viewController, animated: true)
        case .present:
            rootViewController?.present(viewController, animated: true)
        }
    }
}

private extension DetailsNavigator {
    func makeViewController(
        for destination: Destination
        ) -> UIViewController? {
        switch destination {
        case let .imgurList(viewModel):
            return MainViewController.makeViewController(viewModel: viewModel, navigator: self)
        case let .detailView(data):
            return DetailViewController.makeViewController(data: data, navigator: self)
        }
    }
}
