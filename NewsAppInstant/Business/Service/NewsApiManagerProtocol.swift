//
//  NewsApiManagerProtocol.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation

public protocol NewsApiManagerProtocol {
    
    /// Initializes an instance with a service conforming to the NewsApiServiceProtocol.
    /// - Parameter service: The service responsible for handling API requests related to news.
    init(service: NewsApiServiceProtocol)
    
    /// Retrieves a list of articles using a networking service.
    /// - Parameter completion: A closure to be called with the result of the operation.
    func getArticlesList(completion: @escaping (Result<NewsResponse, NetworkingServiceError>) -> Void)
}


public class NewsApiManager: NewsApiManagerProtocol {
    
    // var
    var service: NewsApiServiceProtocol
    
    /// Initializes an instance with a service conforming to the NewsApiServiceProtocol.
    /// - Parameter service: The service responsible for handling API requests .
    required public init(service: NewsApiServiceProtocol) {
        self.service = service
    }
    
    
    /// Retrieves a list of articles using a networking service.
    /// - Parameter completion: A closure to be called with the result of the operation.
    public func getArticlesList(completion: @escaping (Result<NewsResponse, NetworkingServiceError>) -> Void) {
        service.getArticlesList { result in
            switch result {
            case let .failure(error):
                print(error)
                break
            case .success(_):
                completion(result)
                break
            }
        }
    }
    
}
