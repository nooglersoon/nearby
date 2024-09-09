import Foundation

public typealias HTTPHeaders = [String : String]
public typealias HTTPParameters = [String : Any]

public protocol RemoteAPISetup {
    var baseURL: URL { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var authorization: HTTPAuthorizationType { get }
    var parameters: HTTPParameters { get }
    var data: Data? { get }
}

public enum HTTPAuthorizationType {
    case basic(String)
    case bearer(String)
    case none
}

public extension RemoteAPISetup {
    var data: Data? { return nil }
    var authorization: HTTPAuthorizationType { return .none }
}

public extension RemoteAPISetup {

    func setupRequest() -> URLRequest? {
        if let url = URL(string: baseURL.absoluteString + endpoint) {
            var request: URLRequest = url.setParameter(parameters: parameters, method: method)
            request.allHTTPHeaderFields = headers.addAuthorization(authorization)
            request.httpMethod = method.rawValue
//            if isLoggingModeEnabled { logRequest(withRequest: request) }
            return request
        }
        return nil
    }
    
    func setupUploadRequest() -> URLRequest? {
        if let url = URL(string: baseURL.absoluteString + endpoint) {
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers.addAuthorization(authorization)
            request.cachePolicy = .returnCacheDataElseLoad
            request.timeoutInterval = 30
//            if isLoggingModeEnabled { logRequest(withRequest: request) }
            return request
        }
        return nil
    }
    
    func logRequest(withRequest request: URLRequest) {
        print("======================START REQUESTING===============================")
        print("HEADER = \(String(describing: request.allHTTPHeaderFields))")
        print("BODY = \(String(data: request.httpBody ?? Data(), encoding: .ascii) ?? "EMPTY")")
        print("URL = \(String(describing: request.url?.absoluteString))")
        print("METHOD = \(request.httpMethod ?? "NONE")")
        print("======================FINISH REQUESTING===============================")
    }
}


private extension Dictionary where Key == String, Value == String {
    func addAuthorization(_ authorization: HTTPAuthorizationType) -> Self {
        var headers = self
        switch authorization {
        case let .basic(token):
            headers["Authorization"] = "Basic \(token)"
        case let .bearer(token):
            headers["Authorization"] = "Bearer \(token)"
        case .none:
            break
        }
        return headers
    }
}

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
