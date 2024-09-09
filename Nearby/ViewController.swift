import UIKit
import NetworkService

struct NumberAPIResponse: Codable {
    let text: String?
    let found: Bool?
    let number: Int?
    let type, date: String?
}

enum NumberAPIEndpoint: RemoteAPISetup {
    
    case randomYear
    
    var method: HTTPMethod {
        .get
    }
    
    var baseURL: URL {
        URL(string: "http://numbersapi.com")!
    }
    
    var endpoint: String {
        "/random/year?json"
    }
    
    var headers: HTTPHeaders {
        [:]
    }
    
    var parameters: HTTPParameters {
        [:]
    }
    
    
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        // Implementation

        let remoteDataSource: RemoteDataSourceType = RemoteDataSource()

        Task {
            do {
                let result3 = try await remoteDataSource.createRequest(NumberAPIEndpoint.randomYear, for: NumberAPIResponse.self)
                let result1 = try await remoteDataSource.createRequest(NumberAPIEndpoint.randomYear, for: NumberAPIResponse.self)
                let result2 = try await remoteDataSource.createRequest(NumberAPIEndpoint.randomYear, for: NumberAPIResponse.self)
                
                print(result1)
                print(result2)
                print(result3)
            } catch let error {
                print(error)
            }
        }
    }
}

