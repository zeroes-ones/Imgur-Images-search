//
//  MainCoordinator.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

struct MainCoordinator: Coordinator {
    private let navigator: DetailsNavigator

    var navigationViewController: UINavigationController? {
        return navigator.navigationController
    }

    init(rootViewController: UIViewController? = nil, destination: Destination) {
        var navigator: DetailsNavigator {
            switch destination {
            case let .imgurList(viewModel):
                return DetailsNavigator(root: rootViewController, destination: .imgurList(viewModel), navigationType: .push)
            }
        }
        self.navigator = navigator
    }

    func start() {
        navigator.navigate()
    }
}

extension MainCoordinator {
    enum Destination {
        case imgurList(ImgurViewModel)
    }
}
