//
//  NewsViewRouter.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation
import UIKit

class NewsViewRouter: NewsViewRouting {
  
    var navigationController: UINavigationController?
    
    /// Routes to the article details screen for a given article.
    /// - Parameter article: The article for which details are to be displayed.
    func routeToArticleDetails(for article: Article) {
        let vc = AppDependencies.shared.makeNewsDetailsViewController(for: article)
        navigationController?.pushViewController(vc, animated: true)
    }
}
