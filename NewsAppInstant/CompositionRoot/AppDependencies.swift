//
//  AppDependencies.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation
import UIKit

class AppDependencies {
    var window: UIWindow?
    
    private init(){
        
    }

    // dependecies
    static let shared = AppDependencies()
    
    private lazy var client: HTTPClient = {
        return URLSessionHTTPClient(session: URLSession.shared)
    }()
    
    private lazy var service: NewsApiServiceProtocol = {
        let apiKey = "d050a588ac164d6f92580aa1c0b5540a"
        return NewsApiService(baseURL: URL(string: "https://newsapi.org/v2/everything/")!, client: client, apiKey: apiKey)
    }()
    
    private lazy var manager: NewsApiManagerProtocol = {
        return NewsApiManager(service: service)
    }()
    

    
    /// Configures the main window for the provided UIScene.
    /// - Parameter scene: The UIScene for which the main window is configured.
    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }
    
    
    /// launch application
    public func start() {
        setRootViewController(makeNewsViewController())
    }
    
    
    /// Sets the provided ViewController as the root view controller of the window.
    /// - Parameter viewController: The view controller to be set as the root view controller.
    public func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
    }
    
    
    /// Creates a NewsViewController with its associated view model and router.
    /// - Returns: A configured NewsViewController embedded in a UINavigationController.
    func makeNewsViewController() -> UIViewController {
        
        let viewModel = NewsControllerViewModel(manager: manager)
        let router = NewsViewRouter()
        let viewController = NewsViewController(viewModel: viewModel, router: router)
        viewController.title = "Articles"
        let navigationController = UINavigationController(rootViewController: viewController)
        router.navigationController = navigationController
        return navigationController
    }
    
    
    /// Creates a NewsDetailsViewController for a given article.
    ///
    /// - Parameter article: The article for which the details view controller is created.
    /// - Returns: A NewsDetailsViewController configured with the provided article.
    func makeNewsDetailsViewController(for article: Article) -> UIViewController {
        let viewModel = NewsDetailsViewControllerViewModel(article: article)
        let viewController = NewsDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
