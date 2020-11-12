//
//  Request.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

typealias ImgurResult<T: Codable, E: Error> = (Result<T, E>) -> Void

protocol ImgurAPIRequest {
    func fetchImgurGallery(page: Int, text: String, completion: @escaping ImgurResult<[ImgurModel.Data], ImgurFetchError>)
}
