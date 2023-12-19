//
//  NewsControllerViewModel.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation


class NewsControllerViewModel {
    
    ///vars
    private var manager: NewsApiManagerProtocol
    
    var reloadTableView: () -> Void = { }
    
    public var articles: [Article] = []
    
    init(manager: NewsApiManagerProtocol) {
        self.manager = manager
    }
    
    
    // getData
    public func getData(completion: @escaping ([Article]) -> Void) {
        manager.getArticlesList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.articles = response.articles
                    print("Articles inside getData: \(self?.articles ?? [])")
                    completion(response.articles)
                case .failure(let error):
                    print("Failed to fetch articles: \(error)")
                    completion([]) // You might want to pass an empty array in case of failure
                }
            }
        }
    }

    
    // get movie at specific index
    func itemAt(indexPath: IndexPath) -> Article {
//        getData()
        return articles[indexPath.row]
    }
    
}
