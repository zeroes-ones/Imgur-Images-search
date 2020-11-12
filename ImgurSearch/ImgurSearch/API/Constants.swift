//
//  Constants.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
enum Imgur {
    struct API {
        static let baseURLPath = "https://api.imgur.com"
        static let galleryURLpath = "\(baseURLPath)/3/gallery/search/time/"
        static let clientID = "Client-ID 126701cd8332f32"
    }
}

func onMain(block: @escaping () -> Void) {
    if Thread.isMainThread {
        block()
        return
    }
    DispatchQueue.main.async {
        block()
    }
}

/// Executes code block on main thread asynchronously in deadline.
///
/// Parameters:
///     - after: deadline to execute block of code
///     - block: block to be executed
func onMainAfter(after: Double, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        block()
    }
}
