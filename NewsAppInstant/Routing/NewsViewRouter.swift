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
    
    func routeToArticleDetails(for article: Article) {
        let vc = AppDependencies.shared.makeNewsDetailsViewController(for: article)
        navigationController?.pushViewController(vc, animated: true)
    }
}
