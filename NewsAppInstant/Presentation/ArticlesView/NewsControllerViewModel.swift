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
    
  
    /// Initializes an instance with a manager conforming to the NewsApiManagerProtocol.
    /// - Parameter manager: The manager responsible for handling API .
    init(manager: NewsApiManagerProtocol) {
        self.manager = manager
    }
    
    
    /// Fetches data, typically a list of Article objects, and calls the completion handler when done.
    /// - Parameter completion: A closure to be called with the fetched Articles or an empty array in case of failure.
    public func getData(completion: @escaping ([Article]) -> Void) {
        manager.getArticlesList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.articles = response.articles
                    print("Articles inside getData: \(self?.articles ?? [])")
                    completion(response.articles)
                    self?.reloadTableView()
                case .failure(let error):
                    print("Failed to fetch articles: \(error)")
                    completion([]) // You might want to pass an empty array in case of failure
                }
            }
        }
    }

    
    
    /// Retrieves the Article object at the specified IndexPath.
    /// - Parameter indexPath: The IndexPath indicating the position of the Article in the list.
    /// - Returns: Article object at the specified IndexPath.
    func itemAt(indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    
}
