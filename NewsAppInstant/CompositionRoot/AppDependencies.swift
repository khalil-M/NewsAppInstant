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
    

    
    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }
    
    // launch the application
    public func start() {
        setRootViewController(makeNewsViewController())
    }
    
    // set the first root of the application
    public func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
    }
    
    
    func makeNewsViewController() -> UIViewController {
        
        let viewModel = NewsControllerViewModel(manager: manager)
        let router = NewsViewRouter()
        let viewController = NewsViewController(viewModel: viewModel, router: router)
        viewController.title = "Articles"
        let navigationController = UINavigationController(rootViewController: viewController)
        router.navigationController = navigationController
        return navigationController
    }
    
    // create DetailViewController
    func makeNewsDetailsViewController(for article: Article) -> UIViewController {
        let viewController = NewsDetailsViewController(article: article)
        return viewController
    }
}
