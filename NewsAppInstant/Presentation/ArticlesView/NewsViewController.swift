//
//  NewsViewController.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    let viewModel: NewsControllerViewModel
    
    let router: NewsViewRouter
    
    private var articles: [Article] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: NewsControllerViewModel, router: NewsViewRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: "NewsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getData { [weak self] articles in
            self?.articles = articles
            self?.tableView.reloadData()
        }
        
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: Bundle(for: self.classForCoder)), forCellReuseIdentifier: "NewsTableViewCell")
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.itemAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.itemAt(indexPath: indexPath)
        router.routeToArticleDetails(for: article)
        
    }
    
    
}
