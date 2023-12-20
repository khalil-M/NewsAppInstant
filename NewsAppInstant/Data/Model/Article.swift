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
        var id: String?
        var name: String
    }

    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: String?
    var content: String?
}

public struct NewsResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

