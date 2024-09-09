import Foundation

public protocol RemoteDataSourceType {
    func createRequest<ResponseBody: Decodable>(
        _ endpoint: RemoteAPIEndpoint,
        for type: ResponseBody.Type
    ) async throws -> ResponseBody
}

public protocol RemoteAPIEndpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var body: [String: Any]? { get }
}

public struct RemoteDataSource: RemoteDataSourceType {
    
    private let httpClient: URLSessionHTTPClient
    
    init(httpClient: URLSessionHTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
    public func createRequest<ResponseBody: Decodable>(_ endpoint: RemoteAPIEndpoint, for type: ResponseBody.Type) async throws -> ResponseBody {
        try await executeRequest(endpoint, for: type)
    }
    
    private func executeRequest<ResponseBody: Decodable>(
        _ endpoint: RemoteAPIEndpoint,
        for type: ResponseBody.Type
    ) async throws -> ResponseBody {
        
        do {
            // TODO: Make URL & Request
            let (responseBody, _) = try await httpClient
                .execute(with: .init(url: URL(string: endpoint.path)!), for: type)
                .get()
            
            // TODO: Invoke the response for logging
            
            guard let responseBody else {
                throw URLError(.unknown)
            }
            
            return responseBody
            
        } catch let error as HTTPError {
            throw error
        }
        
    }
    
}
