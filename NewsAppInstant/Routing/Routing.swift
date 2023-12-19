//
//  Routing.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation
import UIKit

protocol Routing {
    var navigationController: UINavigationController? { set get }
}

// Routes
protocol NewsViewRouting: Routing {
    
    /// Routes to the article details screen for a given article.
    /// - Parameter article: The article for which details are to be displayed.
    func routeToArticleDetails(for article: Article)
}
