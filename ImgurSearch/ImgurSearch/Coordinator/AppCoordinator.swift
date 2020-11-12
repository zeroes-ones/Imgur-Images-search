//
//  AppCoordinator.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

/// Handle all app level resources
final class AppCoordinator: Coordinator {

    private let window: UIWindow?
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?

    init(
        window: UIWindow?,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        self.window = window
        self.launchOptions = launchOptions
    }

    func start() {
        let mainCoordinator =  MainCoordinator(destination: .imgurList(ImgurViewModel(apiManager: ImgurAPIManager())))
        mainCoordinator.start()
        window?.rootViewController = mainCoordinator.navigationViewController
        window?.makeKeyAndVisible()
    }
}
