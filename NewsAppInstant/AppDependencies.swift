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
    
    private lazy var service: TheMDBApiServiceProtocol = {
        let apiKey = "8290a6cd7f5454ee042badd9ac77160f"
        return TheMDBApiService(baseURL: URL(string: "https://api.themoviedb.org/3/movie/")!, client: client, apiKey: apiKey)
    }()
    
    private lazy var theMDBManager: TheMDBManagerProtocol = {
        return TheMDBManager(service: service)
    }()
    

    
    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }
    
    // launch the application
    public func start() {
        setRootViewController(makeHomeViewController())
    }
    
    // set the first root of the application
    public func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
    }
    
    // create makeHomeViewController
    func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewControllerViewModel(manager: theMDBManager)
        let router = HomeViewRouter()
        let viewController = HomeViewController(viewModel: viewModel, router: router)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        router.navigationController = navigationController
        return navigationController
    }
    
    // create DetailViewController
    func makeMovieDetailsViewController(for movieId: Int) -> UIViewController {
        let viewModel = MovieDetailsViewControllerViewModel(id: movieId, manager: theMDBManager)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
