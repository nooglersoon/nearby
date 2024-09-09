import Foundation

public struct HTTPResponse {
    public let statusCode: Int
    public let headers: [String: String]
    public let rawData: Data?
    
    public init(statusCode: Int, headers: [String: String], rawData: Data?) {
        self.statusCode = statusCode
        self.headers = headers
        self.rawData = rawData
    }
}

extension HTTPResponse {
    init(response: HTTPURLResponse, data: Data?) {
        self.init(
            statusCode: response.statusCode,
            headers: response.allHeaderFields.reduce(into: [:]) {
                guard
                    let key = $1.key as? String,
                    let value = $1.value as? String else { return }
                $0[key] = value
            },
            rawData: data
        )
    }
}

public enum HTTPError: Error {
    case defined(HTTPResponse)
    case decoding(DecodingError)
    case generic(Error)
}
