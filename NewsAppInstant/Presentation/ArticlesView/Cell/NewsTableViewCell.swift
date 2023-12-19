//
//  NewsTableViewCell.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var task: URLSessionDataTask?

    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.contentMode = .scaleToFill
        newsImage.layer.cornerRadius = 5
    }

    func configure(with article: Article) {
        titleLabel.text = article.title
        guard let imageUrl = article.urlToImage else {return}
        
        do {
            if let cachedImage = try OnDiskImageCaching.publicCache.image(url: imageUrl) {
                DispatchQueue.main.async {
                    self.newsImage.image = cachedImage
                }
                return
            }
        } catch {
        }
        task = newsImage.downloadImage(fromURL: imageUrl)
    }
    
}
