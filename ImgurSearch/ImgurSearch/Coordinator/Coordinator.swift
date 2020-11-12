//
//  Coordinator.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
/// Base abstract coordinator generic over the return type of the `start` method.
protocol Coordinator {
    /// Starts job of the coordinator.
    func start()
}
