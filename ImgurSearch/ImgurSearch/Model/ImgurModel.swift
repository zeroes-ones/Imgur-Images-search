//
//  ImgurModel.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

enum ImgurModel { }

extension ImgurModel {
    struct Data: Codable, Equatable {
        let id: String?
        let title: String?
        let description: String?
        let link: String?
        let nsfw: Bool
        let tags: [Tag]?
        let images: [Image]?

        var url: URL? {
            if let link = link, link.hasSuffix("png") || link.hasSuffix("jpg") {
                return URL(string: link)
            } else if let imageLink = images?.first(where: { image -> Bool in
                if let link = image.link, link.hasSuffix("png") || link.hasSuffix("jpg") {
                    return true
                }
                return false
            })?.link {
                return URL(string: imageLink)
            }
            return nil
        }
    }

    struct Tag: Codable, Equatable {
        let name: String?
        let displayName: String?
        let totalItems: Int?
    }

    struct Image: Codable, Equatable {
        let id: String?
        let title: String?
        let description: String?
        let nsfw: Bool
        let link: String?
        let tags: [Tag]?
    }
}
