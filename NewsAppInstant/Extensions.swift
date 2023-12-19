//
//  Extensions.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation
import UIKit

extension URL {
    func appendingQueryItem(name: String, value: String) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var queryItems = components.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value))
        components.queryItems = queryItems
        return components.url!
    }
}

extension UIImageView {
    
    /// Downloads an image from the specified URL and caches it.
    /// - Parameter url: The URL of the image to be downloaded.
    /// - Returns: URLSessionDataTask representing the image download task.
    func downloadImage(fromURL url:URL) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let strongSelf = self else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType,
                  mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.image = image
                
                do {
                   try OnDiskImageCaching.publicCache.cacheImage(image, url: url)
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        task.resume()
        return task
    }
}

