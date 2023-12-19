//
//  NewsViewController.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    let viewModel: NewsControllerViewModel
    
    private var articles: [Article] = []
    
    
    init(viewModel: NewsControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "NewsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData { [weak self] articles in
            self?.articles = articles
            print("$$$$$$$$\(articles)")
        }
    }


}
