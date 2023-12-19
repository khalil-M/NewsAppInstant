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
    
    @IBOutlet weak var linkLabel: UILabel!
    
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
        configureLikRedirection()
    }
    
    private func configureUI() {
        articleImage.contentMode = .scaleToFill
        articleImage.layer.cornerRadius = 5
        articleTitleLabel.text = viewModel.article.description
        linkLabel.attributedText = createAttributedText()
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

extension NewsDetailsViewController {
    
    
    private func configureLikRedirection() {
        linkLabel.attributedText = createAttributedText()
        addSeeMoreGestureToLabel()
    }
    
    private func createAttributedText() -> NSAttributedString {
        let tappedLink = "See More!!"
        let attributedString = NSMutableAttributedString(string: tappedLink)
        
        if let range = tappedLink.range(of: "See More") {
            let nsRange = NSRange(range, in: tappedLink)
            
            attributedString.addAttribute(.link, value: viewModel.article.url, range: nsRange)
        }
        
        return attributedString
    }

    
    private func addSeeMoreGestureToLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func labelTapped() {
        if let articleURL = viewModel.article.url {
            UIApplication.shared.open(articleURL)
        }
    }
}
