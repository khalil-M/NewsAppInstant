//
//  NewsApiManagerProtocol.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation

public protocol NewsApiManagerProtocol {
    
    init(service: NewsApiServiceProtocol)
    func getArticlesList(completion: @escaping (Result<NewsResponse, NetworkingServiceError>) -> Void)
}


public class NewsApiManager: NewsApiManagerProtocol {
    
    
    var service: NewsApiServiceProtocol
    
    required public init(service: NewsApiServiceProtocol) {
        self.service = service
    }
    
    // get list of movies
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
