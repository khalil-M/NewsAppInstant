//
//  Article.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation

import Foundation

public struct Article: Codable {
    struct Source: Codable {
        let id: String?
        let name: String
    }

    let source: Source
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL?
    let publishedAt: Date
    let content: String
}

public struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

