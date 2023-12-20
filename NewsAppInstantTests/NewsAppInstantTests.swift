import XCTest
@testable import NewsAppInstant

class NewsControllerViewModelTests: XCTestCase {

    // MARK: - Mocks
    class MockNewsApiManager: NewsApiManagerProtocol {
        var shouldSucceed: Bool = true
        var newsApiService: NewsApiServiceProtocol

        required init(service: NewsApiServiceProtocol) {
            self.newsApiService = service
        }

        func getArticlesList(completion: @escaping (Result<NewsResponse, NetworkingServiceError>) -> Void) {
            if shouldSucceed {
                let mockResponse = NewsResponse(status: "testStatus", totalResults: 1, articles: [Article(source: Article.Source(id: "test", name: "firstName"), title: "firstTitle")])
                completion(.success(mockResponse))
            } else {
                completion(.failure(.connectivity))
            }
        }
    }

    // MARK: - Mocks
    class MockNewsApiService: NewsApiServiceProtocol {
        private let baseURL: URL
        private let client: NewsAppInstant.HTTPClient
        private let apiKey: String

        required init(baseURL: URL, client: NewsAppInstant.HTTPClient, apiKey: String) {
            self.baseURL = baseURL
            self.client = client
            self.apiKey = apiKey
        }

        func getArticlesList(completion: @escaping (Result<NewsResponse, NetworkingServiceError>) -> Void) {
            let mockResponse = NewsResponse(status: "testStatus", totalResults: 1, articles: [Article(source: Article.Source(id: "test", name: "firstName"), title: "firstTitle")])
            completion(.success(mockResponse))
        }
    }

    // MARK: - Properties
    var viewModel: NewsControllerViewModel!
    var mockManager: MockNewsApiManager!
    let testBaseURL = URL(string: "https://newsapi.org/v2/everything/")!
    let apiKey = "d050a588ac164d6f92580aa1c0b5540a"
    private lazy var client: HTTPClient = {
        return URLSessionHTTPClient(session: URLSession.shared)
    }()


    // MARK: - Setup and Teardown
    override func setUpWithError() throws {
        try super.setUpWithError()
        let mockService = MockNewsApiService(baseURL: testBaseURL, client: client, apiKey: apiKey)
        mockManager = MockNewsApiManager(service: mockService)
        viewModel = NewsControllerViewModel(manager: mockManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockManager = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests

    func testGetDataSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Data should be fetched successfully")
        var capturedArticles: [Article] = []

        // Act
        viewModel.getData { articles in
            capturedArticles = articles
            expectation.fulfill()
        }

        // Simulate successful data fetch
        mockManager.shouldSucceed = true
        mockManager.getArticlesList { _ in }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)

        // Assert
        XCTAssertEqual(capturedArticles.count, 1) // Assuming one mock article is returned
    }
    
    func testItemAt() {
            // Arrange
        viewModel.articles = [Article(source: Article.Source(id: "", name: "first name"), title: "Article 1"), Article(source: Article.Source(id: "", name: "last name"), title: "Article 2")]
            
            // Act
            let indexPath = IndexPath(row: 1, section: 0)
            let resultArticle = viewModel.itemAt(indexPath: indexPath)
            
            // Assert
            XCTAssertEqual(resultArticle.title, "Article 2")
        }
}

