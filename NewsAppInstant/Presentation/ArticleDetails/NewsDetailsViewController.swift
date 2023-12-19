//
//  NewsDetailsViewController.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    //ViewModel
    let viewModel: NewsDetailsViewControllerViewModel
    
    /// Represents a URLSessionDataTask that can be used for network operations.
    var task: URLSessionDataTask?
    
    // outlets
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    
    /// Initializes a NewsDetailsViewController with a view model.
    /// - Parameter viewModel: Inject the viewModell that provides data for the viewController.
    init(viewModel: NewsDetailsViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "NewsDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLikRedirection()
    }
    
    ///Configures the user interface based on the ViewModel data.
    private func configureUI() {
        articleImage.contentMode = .scaleToFill
        articleImage.layer.cornerRadius = 5
        articleTitleLabel.text = viewModel.article.description
        linkLabel.attributedText = createAttributedText()
        guard let imageUrl = viewModel.article.urlToImage else {return}
        
        do {
            // Try to retrieve the cached image from the OnDiskImageCaching
            if let cachedImage = try OnDiskImageCaching.publicCache.image(url: imageUrl) {
                // If the image is found in the cache, update the articleImage asynchronously
                DispatchQueue.main.async {
                    self.articleImage.image = cachedImage
                }
                return
            }
        } catch {
            
        }
        // If the image is not found in the cache, initiate image downloaded
        task = articleImage.downloadImage(fromURL: imageUrl)
    }
    
}

extension NewsDetailsViewController {
    
    
    /// Configures link redirection for the linkLabel.
    private func configureLikRedirection() {
        linkLabel.attributedText = createAttributedText()
        addSeeMoreGestureToLabel()
    }
    
    
    ///  Creates an attributed text with a link attribute.
    /// - Returns: An `NSAttributedString` with a link attribute for the "See More" text.
    private func createAttributedText() -> NSAttributedString {
        let tappedLink = "See More!!"
        let attributedString = NSMutableAttributedString(string: tappedLink)
        
        if let range = tappedLink.range(of: "See More") {
            let nsRange = NSRange(range, in: tappedLink)
            
            attributedString.addAttribute(.link, value: viewModel.article.url, range: nsRange)
        }
        
        return attributedString
    }

    
    /// Adds a tap gesture to enable "see more" functionality on the label.
    private func addSeeMoreGestureToLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(tapGesture)
    }
    
    /// /// Handles the tap gesture on a label.
    @objc private func labelTapped() {
        if let articleURL = viewModel.article.url {
            UIApplication.shared.open(articleURL)
        }
    }
}
