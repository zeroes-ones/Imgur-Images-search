//
//  Navigator.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit
public typealias Presentable = UIViewController

public enum NavigationType {
    case push
    case present
}

protocol Navigator {
    associatedtype Destination
    init(
        root: Presentable?,
        destination: Destination,
        navigationType: NavigationType
    )
    func navigate(
        to destination: Destination,
        type: NavigationType
    )
    func handle(error: Error)
    func navigate()
}

extension Navigator {
    func handle(error: Error) { }
}
