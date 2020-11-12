//
//  ImgurViewModel.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

struct ImgurGalleryError: Error {
    let page: Int
    let error: ImgurFetchError
}

class ImgurViewModel {
    var searchCategory: SearchCategory = .all
    private let apiManager: ImgurAPIRequest
    private var data: [ImgurModel.Data] = []
    private var isLoading = false
    private var pageNumber = 0
    private(set) var searchText: String = ""
    
    var results: [ImgurModel.Data] {
        return searchCategory == .nsfw ? data.filter { $0.nsfw } : data
    }

    var totalRecords: Int {
        return data.count
    }

    var isSearchEmpty: Bool {
        return searchText.isEmpty
    }
    
    init(apiManager: ImgurAPIRequest) {
        self.apiManager = apiManager
    }
}

extension ImgurViewModel {
     func fetchImgurGallery(text: String = "", completion: @escaping ImgurResult<[ImgurModel.Data], ImgurGalleryError>) {
        if isLoading {
            return
        }
        // reset page counter if text changes
        let text = text.trimmingCharacters(in: .whitespaces)
        if !text.isEmpty, searchText != text {
            pageNumber = 0
            self.searchText = text
            self.data.removeAll()
        }

        isLoading = true
        apiManager.fetchImgurGallery(page: pageNumber + 1, text: searchText) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading = false
            switch result {
            case .success(let data):
                self.data += data
                self.pageNumber += 1
                completion(.success(data))
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(ImgurGalleryError(page: self.pageNumber, error: error)))
            }
        }
    }
}


extension ImgurViewModel {
    enum SearchCategory: CaseIterable, RawRepresentable {
        case all
        case nsfw
        // RawRepresentable
        typealias RawValue = String
        init?(rawValue: RawValue) {
            switch rawValue {
            case "All": self = .all
            case "nsfw": self = .nsfw
            default: return nil
            }
        }

        var rawValue: RawValue {
            switch self {
            case .all: return "All"
            case .nsfw: return "nsfw"
            }
        }
    }
}
