import Foundation

public enum NetworkingError: Error {
    case error(Error)
    case noNetworkConnection
    case httpRequestTimedOut
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .error(error):
            return "\(error.localizedDescription)"
        case .noNetworkConnection:
            return "No network connection"
        case .httpRequestTimedOut:
            return "Request timeout"
        }
    }
}
