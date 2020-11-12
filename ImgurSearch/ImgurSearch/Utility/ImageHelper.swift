//
//  ImageHelper.swift
//  ImgurSearch
//
//  Created by S on 11/8/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    static let sharedInstance: ImageHelper = ImageHelper()
    private init() { }
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        guard let data = ImageCache.objectForKey(key: "\(url.absoluteString.hashValue)") else {
            let session = URLSession(configuration: .default)
            DispatchQueue.global(qos: .background).async {
                print("In background")
                session.dataTask(with: URLRequest(url: url)) { data, response, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "Unknown error")
                    }
                    if let data = data, let image = UIImage(data: data) {
                        ImageCache.setObject(data: NSData(data: data), forKey: "\(url.absoluteString.hashValue)")
                        print("Downloaded image")
                        onMain { completion(image) }
                    }
                }.resume()
            }
            return
        }
        DispatchQueue.global(qos: .background).async {
            guard let image = UIImage(data: Data(referencing: data)) else {
                onMain { completion(nil) }
                return
            }
            onMain { completion(image) }
        }
    }
}
