import Foundation

public struct URLSessionHTTPClient: HTTPClient {
    
    public func execute(
        with request: URLRequest
    ) async -> Result<HTTPResponse, HTTPError> {
        
        do {
            let (data, response) = try await executeURLRequest(request)
            
            let statusCode = response.statusCode
            
            // TODO Enhance
            guard [200, 201, 202, 203, 204].contains({statusCode}()) else {
                // Check whether data is needed or not.
                return .failure(.defined(.init(response: response, data: data)))
            }
            
            return .success(.init(response: response, data: data))
            
        } catch let error {
            // General Error
            return .failure(.generic(error))
        }
    }
    
    public func execute<ResponseBody>(
        with request: URLRequest,
        for: ResponseBody.Type
    ) async -> Result<(ResponseBody?, HTTPResponse), HTTPError> where ResponseBody : Decodable {
        
        do {
            let (data, response) = try await executeURLRequest(request)
            
            let statusCode = response.statusCode
            
            // TODO Enhance
            guard [200, 201, 202, 203, 204].contains({statusCode}()) else {
                // Check whether data is needed or not.
                return .failure(.defined(.init(response: response, data: data)))
            }
            
            guard let data else {
                // Handle error has no data
                return .success((nil, .init(response: response, data: nil)))
            }
            
            let jsonDecoder = JSONDecoder()
            
            let responseBody = try jsonDecoder.decode(ResponseBody.self, from: data)
            
            return .success((responseBody, .init(response: response, data: data)))
            
        } catch let error as DecodingError {
            return .failure(.decoding(error))
        } catch let error {
            // General Error
            return .failure(.generic(error))
        }
    }
    
}

extension URLSessionHTTPClient {
    private func executeURLRequest(_ request: URLRequest) async throws -> (Data?, HTTPURLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    let utfData = String(decoding: data ?? Data() , as: UTF8.self).data(using: .utf8)
                    continuation.resume(returning: (utfData, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            .resume()
        }
    }
}
