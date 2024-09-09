import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}

public extension HTTPMethod {
    var value: String {
        return self.rawValue.uppercased()
    }
}

