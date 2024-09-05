import UIKit

struct NumberAPIResponse: Codable {
    let text: String?
    let found: Bool?
    let number: Int?
    let type, date: String?
}

enum NumberAPIEndpoint: RemoteAPIEndpoint {
    
    case randomYear
    
    var method: HTTPMethod {
        .get
    }
    
    var path: String {
        return "http://numbersapi.com/random111/year?json"
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        // Implementation

        let remoteDataSource: RemoteDataSource = StandardRemoteDataSource()

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

