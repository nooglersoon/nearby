import Foundation

extension URL {
    /// Setup request body or query
    /// - Parameters:
    ///   - parameters: body or query
    ///   - method: HTTP method
    func setParameter(parameters: [String: Any], method: HTTPMethod) -> URLRequest {
        switch method {
        case .get:
            if parameters.count <= 0 {
                return URLRequest(url: self)
            } else {
                var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
                var queryItems: [URLQueryItem] = []
                for key in parameters.keys {
                    queryItems.append(URLQueryItem(name: key, value: "\(parameters[key] ?? "")"))
                }
                urlComponents.queryItems = queryItems
                urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                return setupRequest(url: urlComponents.url)
            }
        default:
            do {
                var request = setupRequest()
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
                return request
            } catch {
                return URLRequest(url: self)
            }
        }
    }
    
    private func setupRequest(url: URL? = nil) -> URLRequest {
        var request: URLRequest = URLRequest(url: url ?? self)
        request.timeoutInterval = 15
        return request
    }
}
