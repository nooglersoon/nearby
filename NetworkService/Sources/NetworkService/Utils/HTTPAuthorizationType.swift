import Foundation

public enum HTTPAuthorizationType {
    case basic(String)
    case bearer(String)
    case none
}
