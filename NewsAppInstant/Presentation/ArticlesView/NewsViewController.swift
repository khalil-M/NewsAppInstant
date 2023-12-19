//
//  NewsViewController.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import UIKit

class NewsViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    // vars
    let viewModel: NewsControllerViewModel
    
    let router: NewsViewRouter
    
    private var articles: [Article] = []
    
    /// Initializes a NewsViewController with a view model and a router.
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel providing data for the ViewController.
    ///   - router: The router handling navigation for the ViewController.
    init(viewModel: NewsControllerViewModel, router: NewsViewRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: "NewsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getData { [weak self] articles in
            self?.articles = articles
            self?.tableView.reloadData()
        }
        
        registerCell()
    }
    
    /// /// Registers cell with the tableView
    private func registerCell() {
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: Bundle(for: self.classForCoder)), forCellReuseIdentifier: "NewsTableViewCell")
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate  {
    
    /// Asks the data source to return the number of rows in a specified section .
    ///
    /// - Parameters:
    ///   - tableView: TableView requesting this information.
    ///   - section: An index number identifying a section in tableView.
    /// - Returns: The number of rows in the specified section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    
    /// Asks the data source for a cell to insert in a specific location of the tableView.
    ///
    /// - Parameters:
    ///   - tableView: TableView requesting the cell.
    ///   - indexPath: indexPath that locates a row in tableView.
    /// - Returns: A configured cell for the specified location, or a generic UITableViewCell if the casting fails.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.itemAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: article)
        return cell
    }
    
    /// Notifies the delegate that a row is selected.
    /// - Parameters:
    ///   - tableView: TableView that contains the selected row.
    ///   - indexPath: IndexPath of the selected row.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.itemAt(indexPath: indexPath)
        router.routeToArticleDetails(for: article)
        
    }
    
    
}
