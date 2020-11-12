//
//  ImgurRequest.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

struct ImgurRequest: APIRequest {
    var method: HttpMethod = .get
    var parameters: [String : String] = [String: String]()

    var path: String {
        return "\(page)"
    }

    var headers: [String : String] {
        return [
            "Authorization": Imgur.API.clientID,
            "Content-Type": "application/json",
            "User-Agent": "iOS"
        ]
    }

    var url: URL? {
        return URL(string: Imgur.API.galleryURLpath)
    }

    private let page: Int
    init(page: Int, searchText: String) {
        self.page = page
        parameters["q"] = searchText
    }
}
