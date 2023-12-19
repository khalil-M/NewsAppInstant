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
    
    
    /// Fetches a list of articles.
    /// - Parameter completion: A closure to be called with the result of the operation.
    func getArticlesList(completion: @escaping (Swift.Result<NewsResponse, ServiceError>)->Void)
    
}

public class NewsApiService: NewsApiServiceProtocol {
    
    /// vars
    private var baseURL: URL
    private var client: HTTPClient
    private var apiKey: String
    
    /// Initializes an instance with the specified base URL, HTTP client, and API key.
    ///
    /// - Parameters:
    ///   - baseURL: The base URL for API requests.
    ///   - client: The HTTP client responsible for making network requests.
    ///   - apiKey: The API key used for authentication.
    public required init(baseURL: URL, client: HTTPClient, apiKey: String) {
        self.baseURL = baseURL
        self.client = client
        self.apiKey = apiKey
    }
 
    
    /// Fetches a list of articles related to the query "bitcoin" using a networking client.
    /// - Parameter completion: A closure to be called with the result of the operation.
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


