//
//  NewsDetailsViewController.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    let viewModel: NewsDetailsViewControllerViewModel
    
    var task: URLSessionDataTask?
    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    init(viewModel: NewsDetailsViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "NewsDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        articleImage.contentMode = .scaleToFill
        articleImage.layer.cornerRadius = 5
        articleTitleLabel.text = viewModel.article.description
        guard let imageUrl = viewModel.article.urlToImage else {return}
        
        do {
            if let cachedImage = try OnDiskImageCaching.publicCache.image(url: imageUrl) {
                DispatchQueue.main.async {
                    self.articleImage.image = cachedImage
                }
                return
            }
        } catch {
        }
        task = articleImage.downloadImage(fromURL: imageUrl)
    }


}
