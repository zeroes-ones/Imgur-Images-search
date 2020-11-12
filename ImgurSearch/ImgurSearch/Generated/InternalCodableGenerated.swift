//
//  InternalCodableGenerated.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
extension ImgurModel.Data {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case link
        case nsfw
        case tags
        case images
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        link = try container.decodeIfPresent(String.self, forKey: .link)
        nsfw = try container.decodeIfPresent(Bool.self, forKey: .nsfw) ?? false
        tags = try container.decodeIfPresent([ImgurModel.Tag].self, forKey: .tags)
        images = try container.decodeIfPresent([ImgurModel.Image].self, forKey: .images)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(link, forKey: .link)
        try container.encodeIfPresent(nsfw, forKey: .nsfw)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(images, forKey: .images)
    }
}


extension ImgurModel.Tag {
    private enum CodingKeys: String, CodingKey {
        case name
        case displayName = "display_name"
        case totalItems = "total_items"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        totalItems = try container.decodeIfPresent(Int.self, forKey: .totalItems)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(displayName, forKey: .displayName)
        try container.encodeIfPresent(totalItems, forKey: .totalItems)
    }
}

extension ImgurModel.Image {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case link
        case nsfw
        case tags
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        link = try container.decodeIfPresent(String.self, forKey: .link)
        nsfw = try container.decodeIfPresent(Bool.self, forKey: .nsfw) ?? false
        tags = try container.decodeIfPresent([ImgurModel.Tag].self, forKey: .tags)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(link, forKey: .link)
        try container.encodeIfPresent(nsfw, forKey: .nsfw)
        try container.encodeIfPresent(tags, forKey: .tags)
    }
}
