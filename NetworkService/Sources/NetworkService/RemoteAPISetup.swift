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
