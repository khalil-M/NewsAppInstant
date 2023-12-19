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
    
//    private lazy var theMDBManager: TheMDBManagerProtocol = {
//        return TheMDBManager(service: service)
//    }()
    

    
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
        let viewController = NewsViewController()
        viewController.view.backgroundColor = .red
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        return navigationController
    }
    
    // create DetailViewController
//    func makeMovieDetailsViewController(for movieId: Int) -> UIViewController {
//        let viewModel = MovieDetailsViewControllerViewModel(id: movieId, manager: theMDBManager)
//        let viewController = MovieDetailsViewController(viewModel: viewModel)
//        viewModel.delegate = viewController
//        return viewController
//    }
}
