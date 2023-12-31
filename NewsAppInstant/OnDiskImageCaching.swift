//
//  OnDiskImageCaching.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation
import UIKit

class OnDiskImageCaching {
    
    static let publicCache = OnDiskImageCaching()
    
    private init() {
    }
    
    public final func image(url: URL) throws -> UIImage? {
        
        // lookup into the cache
        // if found, return the image
        return try readFromDisk(withName: url.lastPathComponent)
    }
    
    public final func cacheImage(_ image: UIImage, url: URL) throws {
        // Cache the image
        try saveToDisk(image: image, withName: url.lastPathComponent)
    }
    
    private func readFromDisk(withName name: String, using fileManager: FileManager = .default) throws -> UIImage? {
        let folderURLs = fileManager.urls(for: .cachesDirectory,
                                          in: .userDomainMask)
        
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        
        let data = try Data(contentsOf: fileURL)
        return UIImage(data: data)
    }
    
    private func saveToDisk(image: UIImage, withName name: String, using fileManager: FileManager = .default) throws {
        let folderURLs = fileManager.urls(for: .cachesDirectory,
                                          in: .userDomainMask)
        
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        try image.pngData()?.write(to: fileURL)
        
    }
}
