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

// routeToMovieDetails

protocol NewsViewRouting: Routing {
    func routeToArticleDetails(for article: Article)
}
