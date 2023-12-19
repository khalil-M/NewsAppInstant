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
        let baseURL = URL(string: "https://newsapi.org/v2/everything")!
        let apiKey = "your_api_key_here" // Replace with your actual API key
        let queryParameters: [String: String] = [
            "q": "bitcoin",
            "apiKey": apiKey,
            "language": "en-US",
            "page": "1"
        ]

        let url = baseURL.appendingQueryParameters(queryParameters)

        client.makeRequest(toURL: url, withHttpMethod: .get) { [weak self] result in
            guard let self = self else { return }

            completion(GenericDecoder.decodeResult(result: result))
        }
    }

    
    // get movie by id
    public func getMovie(for id: Int, completion: @escaping (Result<Movie, ServiceError>) -> Void) {
        let url = baseURL
            .appendingPathComponent(String(id))
            .appendingQueryItem(name: "api_key", value: apiKey)
            .appendingQueryItem(name: "language", value: "en-US")
            .appendingQueryItem(name: "page", value: "1")
        
        client.makeRequest(toURL: url, withHttpMethod: .get) { [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }

    
}


