//
//  ImgurAPIManager.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

struct ImgurAPIManager {

    private var session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: URLSessionHandler(), delegateQueue: operationSerialQueue)
    }

    private var operationSerialQueue: OperationQueue {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }
}

extension ImgurAPIManager: ImgurAPIRequest {
    func fetchImgurGallery(page: Int, text: String, completion: @escaping ImgurResult<[ImgurModel.Data], ImgurFetchError>) {
        let imgurRequest = ImgurRequest(page: page, searchText: text)
        guard let url = imgurRequest.url else {
            onMain { completion(.failure(ImgurFetchError.urlError)) }
            return
        }
        session.dataTask(with: imgurRequest.request(with: url)) { data, response, error in
            // check error
            if let _ = error {
                print(String(describing: error))
                onMain { completion(.failure(.apiFailed)) }
                return
            }

            do {
                guard let data = data else {
                    onMain { completion(.failure(.dataCorrupted)) }
                    return
                }
                let dictionaryFromJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                guard let jsonItem = dictionaryFromJSON["data"] as? NSArray else {
                    onMain { completion(.failure(.dataCorrupted)) }
                    return
                }
                let jsonData = try JSONSerialization.data(withJSONObject: jsonItem, options: [])
                let model = try JSONDecoder().decode([ImgurModel.Data].self, from: jsonData)
                onMain { completion(.success(model)) }
                return
            } catch let error {
                print(error)
                onMain { completion(.failure(.decodingError)) }
                return
            }
        }.resume()
    }
}

class URLSessionHandler: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate) {
            completionHandler(.rejectProtectionSpace, nil)
        }
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        }
    }
}
