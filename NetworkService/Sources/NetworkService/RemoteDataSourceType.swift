import Foundation

public protocol RemoteDataSourceType {
    func createRequest<ResponseBody: Decodable>(
        _ endpoint: RemoteAPISetup,
        for type: ResponseBody.Type
    ) async throws -> ResponseBody
}

public struct RemoteDataSource: RemoteDataSourceType {
    
    private let httpClient: URLSessionHTTPClient
    
    public init() {
        self.httpClient = URLSessionHTTPClient()
    }
    
    public func createRequest<ResponseBody: Decodable>(_ endpoint: RemoteAPISetup, for type: ResponseBody.Type) async throws -> ResponseBody {
        try await executeRequest(endpoint, for: type)
    }
    
    private func executeRequest<ResponseBody: Decodable>(
        _ endpoint: RemoteAPISetup,
        for type: ResponseBody.Type
    ) async throws -> ResponseBody {
        
        do {
            
            guard let urlRequest = endpoint.setupRequest() else {
                throw HTTPError.generic(URLError(.badURL))
            }
            
            let (responseBody, _) = try await httpClient
                .execute(with: urlRequest, for: type)
                .get()
            
            guard let responseBody else {
                throw URLError(.unknown)
            }
            
            return responseBody
            
        } catch let error as HTTPError {
            throw error
        }
        
    }
    
}
