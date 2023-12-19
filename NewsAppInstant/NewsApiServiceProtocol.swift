//
//  NewsApiServiceProtocol.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation

public protocol NewsApiServiceProtocol {
    typealias ServiceError = NetworkingServiceError
    init(baseURL: URL, client: HTTPClient, apiKey: String)
    
    // MARK: - Browse
    func getArticlesList(completion: @escaping (Swift.Result<NewsResponse, ServiceError>)->Void)
    
}

public class NewsApiService: NewsApiServiceProtocol {
    
    private var baseURL: URL
    private var client: HTTPClient
    private var apiKey: String
    
    public required init(baseURL: URL, client: HTTPClient, apiKey: String) {
        self.baseURL = baseURL
        self.client = client
        self.apiKey = apiKey
    }
 
    // get list of news
    public func getArticlesList(completion: @escaping (Swift.Result<NewsResponse, ServiceError>) -> Void) {
        let url = baseURL
            .appendingQueryItem(name: "q", value: "bitcoin")
            .appendingQueryItem(name: "apiKey", value: apiKey)
        
        client.makeRequest(toURL: url, withHttpMethod: .get) { [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }

    
}


