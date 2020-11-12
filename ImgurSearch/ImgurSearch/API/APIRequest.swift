//
//  APIRequest.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

enum ImgurFetchError: Error {
    case networkError
    case apiFailed
    case dataCorrupted
    case urlError
    case decodingError
}

public enum HttpMethod: String {
    case get, post, put, delete
    var value: String {
        return self.rawValue
    }
}

protocol APIRequest {
    var method: HttpMethod { get }
    var path: String { get }
    var parameters: [String : String] { get }
    var headers: [String: String] { get }
    var url: URL? { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                             resolvingAgainstBaseURL: false) else {
                                                fatalError("Unable to create URL components")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
